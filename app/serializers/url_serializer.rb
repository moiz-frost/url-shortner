class UrlSerializer < ApplicationSerializer
  attributes :number, :long, :short, :expires_at
  has_many :url_views, key: :views, serializer: UrlViewSerializer

  def expires_at
    object.expires_at.to_i
  end
end
