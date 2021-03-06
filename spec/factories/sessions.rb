# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id             :bigint           not null, primary key
#  current_ip     :string
#  expires_at     :datetime         not null
#  last_active_at :datetime
#  resource_type  :string           not null
#  sign_in_ip     :string
#  token          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  resource_id    :bigint           not null
#
# Indexes
#
#  index_sessions_on_resource  (resource_type,resource_id)
#  index_sessions_on_token     (token) UNIQUE
#
FactoryBot.define do
  factory :session do
    factory :user_session do
      association :resource, factory: :user
    end
  end
end
