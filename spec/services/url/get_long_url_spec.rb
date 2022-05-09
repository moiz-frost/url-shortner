require 'rails_helper'

RSpec.describe UrlService::GetLongUrl, type: :model do
  context 'get long url' do
    it 'should always return nil when no valid url is present' do
      create(:url, original: 'http://google.com/foo?bar=at#anchor&title=title1%20title2%20title3', key: '123')

      expect(UrlService::GetLongUrl.call(key: '123')).to eq 'http://google.com/foo?bar=at#anchor&title=title1 title2 title3'
      expect(UrlService::GetLongUrl.call(key: '1234')).to eq ''
    end
  end
end
