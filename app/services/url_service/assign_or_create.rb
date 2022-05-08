module UrlService
  class AssignOrCreate < ApplicationService
    attr_reader :long_url, :resource

    def initialize(long_url:, resource: nil)
      @long_url = long_url
      @resource = resource
    end

    def call
      unused_url = Url.unused.first || Create.call
      unused_url.update!(
        original: long_url,
        resource: resource,
        expires_at: Time.current + Constants::Url::DEFAULT_EXPIRY
      )
    end
  end
end
