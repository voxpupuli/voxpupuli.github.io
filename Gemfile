# frozen_string_literal: true

source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(URI('https://pages.github.com/versions.json').open.read)

gem 'colorize'
gem 'github-pages', versions['github-pages']
gem 'html-proofer'
gem 'rake'
gem 'rubocop', '~> 1.31'
gem 'rubocop-rake'

# https://github.com/gjtorikian/jekyll-last-modified-at
group :jekyll_plugins do
  gem 'jekyll-last-modified-at'
end
