# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id            :bigint           not null, primary key
#  expires_at    :datetime
#  key           :string
#  original      :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_urls_on_key       (key) UNIQUE
#  index_urls_on_resource  (resource_type,resource_id)
#
require 'rails_helper'

RSpec.describe Url, type: :model do
  context 'presence validations' do
    it 'should validate presence of original and key' do
      expect do
        create(:url, original: '', key: '')
      end.to raise_exception(ActiveRecord::RecordInvalid) { |error| expect(error.message).to eq "Validation failed: Original can't be blank, Key can't be blank" }
    end

    it 'should validate presence of original' do
      expect do
        create(:url, original: '', key: '123')
      end.to raise_exception(ActiveRecord::RecordInvalid) { |error| expect(error.message).to eq "Validation failed: Original can't be blank" }
    end

    it 'should corrently validate original and key' do
      expect do
        create(:url, original: 'http://www.google.com', key: '123')
      end.to_not raise_exception(ActiveRecord::RecordInvalid) { |error| expect(error.message).to eq "Validation failed: Original can't be blank" }
    end
  end

  context 'uniqueness validations' do
    before do
      @url1 = create(:url, original: 'http://google.com/', key: '123')
    end

    it 'should ensure keys are unique' do
      expect do
        create(:url, original: 'http://www.google.com', key: '123')
      end.to raise_exception(ActiveRecord::RecordInvalid) { |error| expect(error.message).to eq 'Validation failed: Key has already been taken' }
    end
  end

  context 'url validations' do
    before do
      @url1 = build(:url, original: 'http://google.com/')
      @url2 = build(:url, original: 'https://google.com/')
      @url3 = build(:url, original: 'google.com')
      @url4 = build(:url, original: 'google')
      @url5 = build(:url, original: 'google.com///123')
      @url6 = build(:url, original: 'http://google.com')
    end

    it 'should correctly validate urls' do
      expect(@url1.valid?).to be true
      expect(@url2.valid?).to be true
      expect(@url3.valid?).to be false
      expect(@url3.errors.to_a).to match ['Original is not a valid URL']
      expect(@url4.valid?).to be false
      expect(@url4.errors.to_a).to match ['Original is not a valid URL']
      expect(@url5.valid?).to be false
      expect(@url5.errors.to_a).to match ['Original is not a valid URL']
      expect(@url6.valid?).to be true
    end
  end

  context 'alias' do
    before do
      @url1 = create(:url, original: 'http://google.com/', key: '123')
      @url2 = create(:url, original: 'http://google.com/', key: '12335')
    end

    it 'should correctly validate urls' do
      expect(@url1.original).to be @url1.long
      expect(@url1.key).to be @url1.short
    end
  end

  context 'url decode' do
    before do
      @url1 = create(:url, original: 'http://google.com/foo?bar=at#anchor&title=title1%20title2%20title3', key: '123')
    end

    it 'should convert original url to a decoded url form' do
      expect(@url1.original).to eq 'http://google.com/foo?bar=at#anchor&title=title1 title2 title3'
    end
  end
end
