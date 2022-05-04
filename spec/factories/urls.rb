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
FactoryBot.define do
  factory :url do
    expires_at { 3.days.from_now }
    sequence(:original) { |n| "LONG_URL #{n}" }
    sequence(:key) { |n| "SHORT_URL #{n}" }

    trait :with_user do
      association :resource, factory: :user
    end
  end
end
