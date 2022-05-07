# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::HttpAuthentication::Basic::ControllerMethods
      include ActionController::HttpAuthentication::Token::ControllerMethods
      include ActionController::RequestForgeryProtection

      protect_from_forgery with: :null_session
      before_action :authenticate

      private

      def authenticate
        authenticate_user_with_token || handle_bad_authentication
      end

      def authenticate_user_with_token
        authenticate_or_request_with_http_token do |token, _options|
          ApiKey.find_by_key(token)
        end
      end

      def handle_bad_authentication
        render status: :unauthorized
      end
    end
  end
end
