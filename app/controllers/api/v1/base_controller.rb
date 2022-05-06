# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include ActionController::RequestForgeryProtection

      protect_from_forgery with: :null_session
      before_action :authenticate

      private

      def authenticate
        authenticate_user_with_token || handle_bad_authentication
      end

      def authenticate_user_with_token
        return false unless request.headers['X_USER_API_KEY'].present?

        @user = ApiKey.find_sole_by(key: request.headers['X_USER_API_KEY']).user
        true
      rescue ActiveRecord::RecordNotFound, ActiveRecord::SoleRecordExceeded
        false
      end

      def handle_bad_authentication
        render status: :unauthorized
      end
    end
  end
end
