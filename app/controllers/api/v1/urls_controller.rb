# frozen_string_literal: true

module Api
  module V1
    class UrlsController < BaseController
      before_action :set_url

      def show
        render json: @url
      end

      private

      def set_url
        @url = Url.find_by!(number: params[:number])
      rescue ActiveRecord::RecordNotFound
        render status: :not_found
      end
    end
  end
end
