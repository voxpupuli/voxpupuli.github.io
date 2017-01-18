# frozen_string_literal: true

begin
  require 'net/http'
  require 'safe_yaml'
  require_relative './support/github_pr_stats'

  desc 'Update _config.yml stats'
  task :update_stats do
    gh_pr_stats = GithubPRStats.new
    result = gh_pr_stats.update

    if ENV['CI'] == 'true' && ENV['TRAVIS'] == 'true' && result
      git_diff = `git diff --stat _config.yml`
      unless git_diff.empty?
        # only commit if the file really has changed
        num_ins = git_diff.match(
          %r{(?<insertions>\d) insertions}
        )[:insertions]
        num_del = git_diff.match(
          %r{(?<deletions>\d) deletions}
        )[:deletions]

        # only continue if there was one and only one line changed
        if num_ins != 1 || num_del != 1
          return 'More than 1 line changed in _config.yml, aborting...'
        end

        system('git status')
        system('git add _config.yml')
        system('git status')
        message = "[TRAVIS-CI] updated _config.yml stats at #{Time.now}"
        system("git commit -m #{message}")
        system('git remote add origin https://github.com/voxpupuli/voxpupuli.github.io.git')
        system('git status')
        system('git log | head -n 30')
        # system('git push origin master')
      end
    end
  end
end
