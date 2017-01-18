# frozen_string_literal: true
require 'net/http'

module Jekyll
  # fetch open pull requests
  class GithubPRStatsTag < Liquid::Tag
    def initialize(tag_name, _args, tokens)
      super
      api_url = 'https://api.github.com/orgs/voxpupuli/repos?per_page=100'
      oauth_client_id = ENV['GH_CLIENT_ID'] ||= nil
      oauth_client_secret = ENV['GH_CLIENT_SECRET'] ||= nil
      @auth_suffix = nil
      if oauth_client_id && oauth_client_secret
        @auth_suffix = "&client_id=#{oauth_client_id}&client_secret=#{oauth_client_secret}"
      end
      @api_url = api_url + @auth_suffix.to_s
      @repos = 0
      @pull_reqs = 0
    end

    def query(url: @api_url, page: 1)
      url = URI.parse(url + "&page=#{page}")
      req = Net::HTTP::Get.new(url.to_s)
      req['Accept'] = 'application/vnd.github.v3+json'
      req['User-Agent'] = 'voxpupuli.org github API'
      res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }

      # see if there are more pages
      next_page = nil
      if res['link']
        res['link'].split(',').each do |link|
          # also catch possibly nested quoting
          if link.match?(%r{rel=(\\|)"next(\\|)"})
            next_url = URI.extract(link)[0]
            next_page = next_url.match(%r{(&|\?)page=(?<page>[0-9]+)})[:page]
          end
        end
      end
      [next_page, JSON.parse(res.body)]
    end

    def process_repos(repositories = {})
      @repos += repositories.length
      # iterate over the repositories
      repositories.each do |repo|
        log("  [+] processing #{repo['name']}...")
        pull_url = repo['pulls_url'].chomp('{/number}')
        pull_url += '?state=open&per_page=100'
        pull_url += @auth_suffix
        next_page = 1
        loop do
          next_page, pull_requests = query(url: pull_url, page: next_page)
          @pull_reqs += pull_requests.length if pull_requests.is_a?(Array)
          break unless next_page
        end
      end
    end

    def log(msg = '')
      p('github_pr_stats.rb: ' + msg.to_s)
    end

    def render(_context)
      # do not even attempt to continue w/o privileged api access
      return Jekyll.configuration['stats']['pr'] unless @auth_suffix

      log('fetching data from github API, this may take a while...')

      begin
        next_page = 1
        loop do
          next_page, repositories = query(url: @api_url, page: next_page)
          process_repos(repositories)
          break unless next_page
        end

        # some build output
        log("github_pr_stats.rb: parsed #{@repos} repositories with #{@pull_reqs} PRs")

        return @pull_reqs
      rescue => err
        p(err)
        return Jekyll.configuration['stats']['pr']
      end
    end
  end
end

Liquid::Template.register_tag('github_pr_stats', Jekyll::GithubPRStatsTag)
