require 'rails_helper'

RSpec.describe UrlService::AssignOrCreate, type: :model do
  context 'assign urls' do
    it 'should always create new urls when unused urls arent present' do
      user = create(:user)

      expect(Url.count).to eq 0

      expect do
        UrlService::AssignOrCreate.call(
          long_url: 'http://google.com/foo?bar=at#anchor&title=title1%20title2%20title3',
          resource: user
        )
      end.to change { Url.count }.by(1)
          .and change { Url.unused.count }.by(0)

      expect(Url.count).to eq 1

      expect(Url.unused.count).to eq 0

      expect(Url.first.long).to eq 'http://google.com/foo?bar=at#anchor&title=title1 title2 title3'
      expect(Url.first.resource).to eq user
    end

    it 'should always assign new urls when unused urls arent present' do
      expect(Url.count).to eq 0
      expect(Url.unused.count).to eq 0

      100.times do
        UrlService::Create.call
      end

      expect(Url.count).to eq 100
      expect(Url.unused.count).to eq 100

      expect do
        UrlService::AssignOrCreate.call(
          long_url: 'http://google.com/foo?bar=at#anchor&title=title1%20title2%20title3'
        )
      end.to change { Url.count }.by(0)
          .and change { Url.unused.count }.by(-1)

      expect(Url.count).to eq 100
      expect(Url.unused.count).to eq 99

      expect(Url.first.long).to eq 'http://google.com/foo?bar=at#anchor&title=title1 title2 title3'
      expect(Url.first.resource).to be_nil
    end
  end
end
