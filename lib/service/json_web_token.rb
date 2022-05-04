require 'jwt'

module Lib
  class Service::JsonWebToken
    class << self
      def encode(payload)
        JWT.encode(payload, Rails.application.credentials[:jwt_secret])
      end

      def decode(token)
        HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials[:jwt_secret])[0])
      end
    end
  end
end
