# puppet-ghostbuster

puppet-ghostbuster is a puppet-lint plugin that detects unused Puppet classes, defines, templates, functions, facts, and Hiera files by querying PuppetDB.

## Prerequisites

- Ruby (rbenv or system)
- puppet-lint 5.x
- puppet-ghostbuster 2.1.0
- Access to PuppetDB with SSL certificates

## Installation

    gem install puppet-lint
    gem install puppet-ghostbuster

Note: puppet-ghostbuster 2.1.0 depends on openvox >= 8.0. Do NOT also install the puppet gem -- having both causes a conflict since they both define the Puppet module.

## SSL Certificates

PuppetDB requires mutual TLS. Export these before running:

    export PUPPETDB_URL='https://puppetdb.example.com:8081'
    export PUPPETDB_CACERT_FILE='/path/to/ca.pem'
    export PUPPETDB_CERT_FILE='/path/to/client.pem'
    export PUPPETDB_KEY_FILE='/path/to/client_key.pem'

puppet-ghostbuster is normally used via the puppet-lint CLI. With puppet-ghostbuster 2.1.0 and puppet-lint 5.x this does not work due to incompatible changes in puppet-lint 5.x (private methods, rc file handling).

The script drives puppet-lint as a Ruby library directly, which is the only reliable way to run ghostbuster with this version combination.

## Try the CLI First

    puppet-lint --config /dev/null \
        --only-checks ghostbuster_classes,ghostbuster_defines,ghostbuster_files,ghostbuster_hiera_files,ghostbuster_templates \
        ./site-modules

--config /dev/null suppresses ~/.puppet-lint.rc but does NOT suppress /etc/.puppet-lint.rc in puppet-lint 5.x. If the command produces no output or behaves unexpectedly, use ghostbuster_scan.rb instead.

Always run from the root of your control repo.

## ghostbuster_scan.rb

'''ruby
#!/usr/bin/env ruby
# Run from the root of your puppet control repo
# Requires env vars for PuppetDB checks:
#   PUPPETDB_URL, PUPPETDB_CACERT_FILE, PUPPETDB_CERT_FILE, PUPPETDB_KEY_FILE

require 'puppet-lint'
require 'puppet-ghostbuster/puppetdb'
require 'puppet-ghostbuster/util'
require 'yaml'

$stderr.puts "Fetching data from PuppetDB..."
pdb = PuppetGhostbuster::PuppetDB.new
classes   = PuppetGhostbuster::PuppetDB.classes
resources = PuppetGhostbuster::PuppetDB.resources
$stderr.puts "Got #{classes.length} classes, #{resources.length} resource types"

all_manifests = Dir.glob('./**/manifests/**/*.pp')
all_templates = Dir.glob('./**/templates/**/*').select { |f| File.file?(f) }
$stderr.puts "Found #{all_manifests.length} manifests, #{all_templates.length} templates"

results = []

def warn(msg, file, line = 1)
  puts "#{file}:#{line} WARNING: #{msg}"
end

# --- Classes and Defines ---
files = Dir.glob('./site-modules/*/manifests/**/*.pp') +
        Dir.glob('./manifests/**/*.pp')

files.each do |file|
  next unless file.match(%r{^\./(:?[^/]+/){2}?manifests/.+$})
  begin
    content = File.read(file)
    PuppetLint::Data.path = file
    PuppetLint::Data.manifest_lines = content.split("\n", -1)
    PuppetLint::Data.tokens = PuppetLint::Lexer.new.tokenise(content)

    PuppetLint::Data.send(:class_indexes).each do |idx|
      t = idx[:name_token]
      title = t.value.split('::').map(&:capitalize).join('::')
      unless classes.include?(title)
        warn "Class #{title} seems unused", file, t.line
        results << title
      end
    end

    PuppetLint::Data.send(:defined_type_indexes).each do |idx|
      t = idx[:name_token]
      type = t.value.split('::').map(&:capitalize).join('::')
      unless resources.include?(type)
        warn "Define #{type} seems unused", file, t.line
        results << type
      end
    end
  rescue => e
    $stderr.puts "Error processing #{file}: #{e}"
  end
end

# --- Templates ---
all_templates.each do |path|
  m = path.match(%r{.*/([^/]+)/templates/(.+)$})
  next if m.nil?
  module_name, template_name = m.captures
  found = all_manifests.any? do |manifest|
    PuppetGhostbuster::Util.search_file(manifest, %r{["']#{module_name}/#{template_name}["']}) ||
      (manifest.match(%r{.*/([^/]+)/manifests/.+$})&.captures&.[](0) == module_name &&
       PuppetGhostbuster::Util.search_file(manifest, %r{["']\$\{module_name\}/#{template_name}["']}))
  end
  unless found
    warn "Template #{module_name}/#{template_name} seems unused", path
    results << path
  end
end

# --- Functions ---
Dir.glob('./**/lib/puppet/parser/functions/*.rb').each do |path|
  m = path.match(%r{.*/[^/]+/lib/puppet/parser/functions/(.+)\.rb$})
  next if m.nil?
  function_name = m.captures[0]
  found = all_manifests.any? { |f| PuppetGhostbuster::Util.search_file(f, "#{function_name}(") } ||
          all_templates.any? { |f| PuppetGhostbuster::Util.search_file(f, /(Puppet::Parser::Functions\.function\(:|scope\.function_)#
{function_name}/) }
  unless found
    warn "Function #{function_name} seems unused", path
    results << path
  end
end

# --- Facts ---
Dir.glob('./**/lib/facter/*.rb').each do |path|
  File.foreach(path) do |line|
    if line =~ /Facter.add\(["':](?<fact>[^"')]+)["']?\)/
      fact_name = Regexp.last_match(:fact)
      found = all_manifests.any? { |f| PuppetGhostbuster::Util.search_file(f, /(\$\{?::#{fact_name}\}?|@#{fact_name})/) } ||
              all_templates.any? { |f| PuppetGhostbuster::Util.search_file(f, /@#{fact_name}/) }
      unless found
        warn "Fact #{fact_name} seems unused", path
        results << fact_name
      end
    end
'''

Usage:

    cd /path/to/puppet/control/repo
    ruby ghostbuster_scan.rb 2>/tmp/ghostbuster_err.txt | tee /tmp/ghostbuster.out
    cat /tmp/ghostbuster.out
    cat /tmp/ghostbuster_err.txt

Always confirm before deleting:

    grep -ri "classname" data/ manifests/ site-modules/
