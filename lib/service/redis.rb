# frozen_string_literal: true

require 'redis'

class Service::Redis
  class << self
    def client
      Redis.new(
        host: server[:host],
        port: server[:port]
      )
    end

    def lock_manager
      Redlock::Client.new([client])
    end

    private

    def server
      {
        host: Rails.application.credentials[:redis][:host],
        port: Rails.application.credentials[:redis][:port],
      }
    end
  end
end
