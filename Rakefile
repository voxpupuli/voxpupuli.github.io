require 'html-proofer'
require 'fileutils'

desc 'Build the site with Jekyll'
task :build do
  sh 'bundle exec jekyll build'
end

desc 'Remove generated site'
task :clean do
  FileUtils.rm_rf('./_site')
end

desc 'Validte _site/ with html-proofer'
task :validate do
  HTMLProofer.check_directory('./_site', {
    :url_ignore => [/voxpupuli.org/],
    :check_html => true,
  }).run
end

desc 'Build and validate the site'
task :test do
  Rake::Task['build'].invoke
  Rake::Task['validate'].invoke
end
