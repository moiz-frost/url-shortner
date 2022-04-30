# frozen_string_literal: true

require 'redis'

module Lib::Service
  class Redis
    class << self
      def client
        Redis.new(
          host: Rails.application.credentials[:redis][:host],
          port: Rails.application.credentials[:redis][:port]
        )
      end
    end
  end
end
