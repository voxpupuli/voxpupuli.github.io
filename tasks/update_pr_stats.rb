# frozen_string_literal: true

begin
  require 'net/http'
  require 'safe_yaml'
  require_relative './support/github_pr_stats'

  desc 'Update _config.yml stats'
  task :update_stats do
    gh_pr_stats = GithubPRStats.new
    result = gh_pr_stats.update

    next unless ENV['CI'] && ENV['CI']
    next unless ENV['TRAVIS'] && ENV['TRAVIS']
    next if result.nil?

    git_diff = `git diff --stat _config.yml`
    p(git_diff)
    unless git_diff.empty?
      # only commit if the file really has changed
      num_ins = git_diff.match(
        %r{(?<insertions>\d) insertion}
      )[:insertions]
      num_del = git_diff.match(
        %r{(?<deletions>\d) deletion}
      )[:deletions]

      p('insertions:', num_ins)
      p('deletions:', num_del)

      # only continue if there was one and only one line changed
      if num_ins.to_i != 1 || num_del.to_i != 1
        puts 'More than 1 line changed in _config.yml, aborting...'
        next
      end

      puts(`git status`)
      system('git config --global user.name "TRAVIS-CI"')
      system('git config --global user.email ""')
      system('git add _config.yml')
      puts(`git status`)
      message = "[TRAVIS-CI] updated _config.yml stats at #{Time.now}"
      puts(`git commit -m "#{message}"`)
      system('git remote add upstream https://github.com/voxpupuli/voxpupuli.github.io.git')
      system('git branch --set-upstream-to upstream/master')
      system('git config --global credential.helper store')
      File.open(Dir.home + '/.git-credentials', 'w') do |f|
        f.write("https://#{gh_pr_stats.token}:x-oauth-basic@github.com\n")
      end
      puts(`git status`)
      puts(`git log -n 1`)
      # system('git push upstream master')
    end
  end
end
