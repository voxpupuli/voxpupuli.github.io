# frozen_string_literal: true

source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'colorize'
gem 'github-pages', versions['github-pages']
gem 'html-proofer'
gem 'rake'
gem 'rubocop', '~> 0.49.1'
gem 'rubocop-rspec', '~> 1.15.0'
