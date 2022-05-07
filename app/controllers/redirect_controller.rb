# frozen_string_literal: true

class RedirectController < ApplicationController
  def action
    long_url = UrlService::RedirectAndView.call(
      key: params[:key],
      user_agent: request.user_agent,
      ip: request.ip,
      referer: request.referer
    )
    if long_url.present?
      redirect_to long_url, status: :found, allow_other_host: true
    else
      head :not_found
    end
  end
end
