# frozen_string_literal: true

require 'colorize'
require 'jekyll'
require 'open3'
require 'json'
require 'date'

require 'rubocop/rake_task'
task default: :test

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['-D', '-S', '-E']
end

desc 'Build the site with Jekyll'
task :build do
  Jekyll::Commands::Build.process(profile: true)
end

desc 'Remove generated site'
task :clean do
  Jekyll::Commands::Clean.process({})
end

desc 'Check for Jekyll deprecation issues'
task :doctor do
  Jekyll::Commands::Doctor.process({})
end

desc 'Build and validate the site'
task :test do
  notify 'Checking code'
  Rake::Task['rubocop'].invoke
  notify 'Building site'
  Rake::Task['build'].invoke
  notify 'Checking for deprecation issues'
  Rake::Task['doctor'].invoke
end

desc 'Build security advisories table'
task :advisories do
  notify 'Retrieving GitHub advisories via API'

  File.open('security/index.md', 'a') do |file|
    file.puts
    file.puts '## Security Advisories'
    file.puts
    file.puts '| Date | CVE ID | Severity | Scores | |'
    file.puts '|------|--------|----------|--------|-|'

    advisories('openvoxproject').each do |advisory|
      file.puts md_advisory_row(advisory)
    end
    advisories('voxpupuli').each do |advisory|
      file.puts md_advisory_row(advisory)
    end
    file.puts '{: .table .text-nowrap .table-sm .small}'
  end
end

def advisories(org, state = 'published')
  stdout, stderr, status = Open3.capture3(
    'gh', 'api',
    '-H', 'Accept: application/vnd.github+json',
    '-H', 'X-GitHub-Api-Version: 2022-11-28',
    "/orgs/#{org}/security-advisories?state=#{state}"
  )

  raise "Error retrieving advisories for #{org}: #{stderr}" unless status.success?

  JSON.parse(stdout)
end

def md_advisory_row(advisory)
  date     = Date.parse(advisory['published_at']).strftime('%Y-%m-%d')
  cve      = advisory['cve_id']
  severity = advisory['severity']
  scores   = advisory['cvss_severities'].values.map { |elem| elem['score'] }.compact.join '/'
  infolink = "[#{advisory['summary']}](#{advisory['html_url']})"

  "| #{date} | #{cve} | #{severity} | #{scores} | #{infolink} |"
end

def notify(message)
  puts
  puts '###################################################'.blue
  puts "#{message}...".blue
  puts '###################################################'.blue
  puts
end
