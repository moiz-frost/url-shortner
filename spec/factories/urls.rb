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
    trait :with_user do
      association :resource, factory: :user
    end

    expires_at { 3.days.from_now }
    original { Faker::Internet.url }
    key { Base62.encode(Faker::Number.number) }
    view_count { 0 }
  end
end
