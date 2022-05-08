module UrlService
  class RedirectAndView < ApplicationService
    attr_reader :key, :user_agent, :ip, :referer, :viewed_at

    def initialize(key:, user_agent: '', ip: '', referer: '', viewed_at: Time.current)
      @key = key
      @user_agent = user_agent
      @ip = ip
      @referer = referer
      @viewed_at = viewed_at
    end

    def call
      url = Url.find_by_key!(key)
      UrlView.create!(
        url: url,
        user_agent: user_agent,
        ip: ip,
        referer: referer,
        viewed_at: viewed_at
      )
      url.long
    rescue StandardError
      nil
    end
  end
end
