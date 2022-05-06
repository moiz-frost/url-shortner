class UrlViewSerializer < ApplicationSerializer
  attributes :viewed_at, :user_agent, :referer, :ip

  def viewed_at
    object.viewed_at.to_i
  end
end
