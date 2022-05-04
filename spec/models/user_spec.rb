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
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'phone validations' do
    before do
      @user = build(:user)
    end

    it 'should validate email' do
      expect(@user.valid?).to be true

      @user.email = 'asd@??.com'
      expect(@user.valid?).to be false

      @user.email = 'abc@@google.com'
      expect(@user.valid?).to be false
    end

    it 'should validate phone' do
      expect(@user.valid?).to be true

      @user.phone = '3143112123'
      expect(@user.valid?).to be false

      @user.phone = '12312312'
      expect(@user.valid?).to be false

      @user.phone = '+13177587403'
      expect(@user.valid?).to be true
    end
  end

  context 'password validations' do
    it 'should have a default passwork set when no password is provided on user creation' do
      user = create(:user, password: '')
      expect(user.password).to be_truthy
    end

    it 'should have allow a custom password' do
      user = create(:user, password: 'QwerttyioP')
      expect(user.password).to be_truthy
      expect(user.password).to eq 'QwerttyioP'
    end
  end
end
