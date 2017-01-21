# frozen_string_literal: true
source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'colorize'
gem 'github-pages', versions['github-pages']
gem 'html-proofer'
gem 'rake'
gem 'rubocop'
gem 'rubocop-rspec'
gem 'safe_yaml'
