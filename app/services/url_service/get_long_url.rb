module UrlService
  class GetLongUrl < ApplicationService
    attr_reader :key

    def initialize(key:)
      @key = key
    end

    def call
      Url.find_by_key(key)&.long || ''
    end
  end
end
