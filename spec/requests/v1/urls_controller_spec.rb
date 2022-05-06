require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :request do
  before do
    @user = create(:user)
    @api_key = create(:api_key, user: @user, is_active: true)
    @url1 = create(
      :url,
      :with_user,
      original: 'http://google.com/',
      key: '123',
      resource: @user
    )

    @headers = {
      'Accept' => 'application/json',
      'X_USER_API_KEY' => @api_key.key,
    }
  end

  context 'validate token' do
    it 'returns 400 when invalid token is set' do
      get "/api/v1/urls/#{@url1.number}", headers: {
        'X_USER_API_KEY' => '123',
      }

      expect(response).to have_http_status 401
    end
  end

  context 'GET /api/v1/urls/:url_number' do
    it 'returns the correct url' do
      get "/api/v1/urls/#{@url1.number}", headers: @headers
      expect(JSON.parse(response.body)).to eq({
        'expires_at' => @url1.expires_at.to_i,
        'long' => @url1.long,
        'number' => @url1.number,
        'short' => @url1.key,
        'views' => [],
      })
      expect(response.body).to match ActiveModelSerializers::SerializableResource.new(@url1).to_json
      expect(response).to have_http_status 200

      get '/api/v1/urls/123', headers: @headers
      expect(response).to have_http_status 404
    end

    it 'returns the correct url with views' do
      v1 = create(:url_view, url: @url1)
      v2 = create(:url_view, url: @url1)
      v3 = create(:url_view, url: @url1)
      v4 = create(:url_view, url: @url1)

      get "/api/v1/urls/#{@url1.number}", headers: @headers
      expect(JSON.parse(response.body)).to match({
        'expires_at' => @url1.expires_at.to_i,
        'long' => @url1.long,
        'number' => @url1.number,
        'short' => @url1.key,
        'views' => [
          {
            'viewed_at' => v1.viewed_at.to_i,
            'user_agent' => v1.user_agent,
            'referer' => v1.referer,
            'ip' => v1.ip,
          },
          {
            'viewed_at' => v2.viewed_at.to_i,
            'user_agent' => v2.user_agent,
            'referer' => v2.referer,
            'ip' => v2.ip,
          },
          {
            'viewed_at' => v3.viewed_at.to_i,
            'user_agent' => v3.user_agent,
            'referer' => v3.referer,
            'ip' => v3.ip,
          },
          {
            'viewed_at' => v4.viewed_at.to_i,
            'user_agent' => v4.user_agent,
            'referer' => v4.referer,
            'ip' => v4.ip,
          }
        ],
      })

      expect(response.body).to match ActiveModelSerializers::SerializableResource.new(@url1).to_json
      expect(response).to have_http_status 200
    end
  end
end
