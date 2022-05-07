module UrlService
  class GetLongUrl
    include Callable

    def initialize(key:)
      @key = key
    end

    def call
      Url.find_by_key(key)&.long
    end

    private

    attr_reader :key
  end
end
