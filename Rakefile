# frozen_string_literal: true

require 'colorize'
require 'jekyll'

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

def notify(message)
  puts
  puts '###################################################'.blue
  puts "#{message}...".blue
  puts '###################################################'.blue
  puts
end
