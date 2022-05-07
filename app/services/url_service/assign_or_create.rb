module UrlService
  class AssignOrCreate
    include Callable

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

    private

    attr_reader :long_url, :resource
  end
end
