module UrlService
  class Create < ApplicationService
    def call
      new_count = redis.incr(Constants::GLOBAL_URL_COUNTER_KEY)
      new_key = Base62.encode new_count
      Url.create! key: new_key
    end

    private

    def redis
      Service::Redis.client
    end
  end
end
