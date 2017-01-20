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

    identity_file = './id_ed25519'
    unless File.exist?(identity_file)
      puts('deploy key not found, skipping git commit & push...')
      next
    end

    # permissions
    system("chmod 0700 #{Dir.pwd}")
    system("chmod 0700 #{Dir.home}")
    system("chmod 0600 #{identity_file}")
    system('umask 077')

    # create symlink for the git ssh wrapper
    system("ln -sf $(readlink -f #{identity_file}) #{Dir.home}/id_deploy")
    system("chmod 0600 #{Dir.home}/id_deploy")

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

      system('git config --global user.name "TRAVIS-CI"')
      system('git config --global user.email "travis@voxpupuli"')
      system('git add _config.yml')
      message = "[TRAVIS-CI] updated _config.yml stats at #{Time.now}"
      system("git commit -m '#{message}'")
      system('git remote add upstream git@github.com:voxpupuli/voxpupuli.github.io.git')
      system('git fetch -p upstream')
      puts(`git log -n 1`)
      ENV['SSH_AUTH_SOCK'] = nil
      system('unset SSH_AUTH_SOCK')
      system('GIT_SSH="./tasks/support/git_ssh_wrapper" git push -f -u upstream HEAD:update-gh-pr-stats-travis')
      # system('git push upstream HEAD:master')

      # cleanup, just in case
      system("rm -f #{identity_file}")
    end
  end
end
