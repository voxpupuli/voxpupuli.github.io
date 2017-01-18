# frozen_string_literal: true
require 'net/http'

module Jekyll
  # fetch repository count
  class GithubRepoStatsTag < Liquid::Tag
    def initialize(tag_name, _args, tokens)
      super
    end

    def render(_context)
      api_url = 'https://api.github.com/orgs/voxpupuli'

      oauth_client_id = ENV['GH_CLIENT_ID'] ||= nil
      oauth_client_secret = ENV['GH_CLIENT_SECRET'] ||= nil

      if oauth_client_id && oauth_client_secret
        api_url += "?client_id=#{oauth_client_id}&client_secret=#{oauth_client_secret}"
      end

      begin
        url = URI.parse(api_url)
        req = Net::HTTP::Get.new(url.to_s)
        req['Accept'] = 'application/vnd.github.v3+json'
        req['User-Agent'] = 'voxpupuli.org github API'
        res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }
        return JSON.parse(res.body)['public_repos']
      rescue => err
        p(err)
        return Jekyll.configuration['stats']['repos']
      end
    end
  end
end

Liquid::Template.register_tag('github_repo_stats', Jekyll::GithubRepoStatsTag)
