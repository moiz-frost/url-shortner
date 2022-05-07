require 'rails_helper'

RSpec.describe UrlService::Create, type: :model do
  context 'creation of unique urls' do
    it 'should always url records without any validation errors' do
      expect do
        UrlService::Create.call
      end.to change { Url.count }.by 1

      expect do
        100.times do
          UrlService::Create.call
        end
      end.to change { Url.count }.by 100

      expect(Url.unused.count).to eq 101
    end
  end
end
