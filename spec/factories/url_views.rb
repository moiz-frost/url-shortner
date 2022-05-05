# == Schema Information
#
# Table name: url_views
#
#  id         :bigint           not null, primary key
#  ip         :string
#  referer    :string
#  user_agent :string
#  viewed_at  :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :bigint           not null
#
# Indexes
#
#  index_url_views_on_url_id  (url_id)
#
# Foreign Keys
#
#  fk_rails_78ca9e6cd6  (url_id => urls.id)
#
FactoryBot.define do
  factory :url_view do
    association :url, factory: :url
    viewed_at { Time.current }
    ip { Faker::Internet.public_ip_v4_address }
    user_agent { Faker::Internet.user_agent }
    referer { Faker::Internet.domain_name }
  end
end
