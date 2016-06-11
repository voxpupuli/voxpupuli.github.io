require 'html-proofer'
require 'jekyll'

task :default => :test

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
  HTMLProofer.check_directory('./_site', {
    :url_ignore => [/voxpupuli.org/],
    :check_html => true,
  }).run
end

desc 'Check for Jekyll deprecation issues'
task :doctor do
  Jekyll::Commands::Doctor.process({})
end

desc 'Build and validate the site'
task :test do
  Rake::Task['build'].invoke
  Rake::Task['validate'].invoke
  Rake::Task['doctor'].invoke
end
