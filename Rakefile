# frozen_string_literal: true

require 'colorize'
require 'html-proofer'
require 'jekyll'

task default: :test

desc 'Run rubocop'
task :rubocop do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |t|
    t.options = ['-D', '-S', '-E']
  end
end

desc 'Build the site with Jekyll'
task :build do
  Jekyll::Commands::Build.process(profile: true)
end

desc 'Remove generated site'
task :clean do
  Jekyll::Commands::Clean.process({})
end

desc 'Validate _site/ with html-proofer'
task :validate do
  HTMLProofer.check_directory(
    './_site',
    url_ignore: [%r{voxpupuli.org}, %r{github.com/voxpupuli/voxpupuli.github.io/edit/master}],
    check_html: true
  ).run
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
  notify 'Validating site'
  Rake::Task['validate'].invoke
  notify 'Checking for deprecation issues'
  Rake::Task['doctor'].invoke
end

def notify(message)
  puts
  puts '###################################################'.blue
  puts "#{message}...".blue
  puts '###################################################'.blue
  puts
end
