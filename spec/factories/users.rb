# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           not null
#  first_name             :string
#  last_name              :string
#  phone                  :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "FirstName - #{n}" }
    sequence(:last_name) { |n| "LastName - #{n}" }
    sequence(:username) { |n| "UserName - #{n}" }
    password { SecureRandom.uuid }
    email { Faker::Internet.email }
  end
end
