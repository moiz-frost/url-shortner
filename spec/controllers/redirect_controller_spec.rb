require 'rails_helper'

RSpec.describe RedirectController, type: :request do
  before do
    @url1 = create(
      :url,
      :with_user,
      original: 'http://google.com/',
      key: '123',
      resource: @user
    )
  end

  context 'GET /api/v1/urls/:url_number' do
    it 'redirects to the correct url' do
      allow_any_instance_of(ActionDispatch::Request).to receive(:user_agent).and_return 'Google chrome'
      allow_any_instance_of(ActionDispatch::Request).to receive(:ip).and_return '::1'
      allow_any_instance_of(ActionDispatch::Request).to receive(:referer).and_return 'google.com'

      expect(UrlView.count).to eq 0

      Timecop.freeze

      get "/#{@url1.key}"

      expect(response.body).to match 'You are being'
      expect(response.body).to match @url1.long
      expect(response.body).to match 'redirected'
      expect(response).to have_http_status 302

      expect(UrlView.count).to eq 1

      expect(UrlView.first.user_agent).to eq 'Google chrome'
      expect(UrlView.first.ip).to eq '::1'
      expect(UrlView.first.referer).to eq 'google.com'
      expect(UrlView.first.viewed_at.to_i).to eq Time.current.to_i

      Timecop.return

      get '/1234'
      expect(response).to have_http_status 404

      expect do
        100.times do
          get "/#{@url1.key}"
        end
      end.to change { @url1.url_views.count }.by 100
    end
  end
end
