# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id             :bigint           not null, primary key
#  current_ip     :inet
#  expires_at     :datetime         not null
#  last_active_at :datetime
#  resource_type  :string           not null
#  sign_in_ip     :inet
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
require 'rails_helper'

RSpec.describe Session, type: :model do
  context 'validations and callbacks' do
    before do
      Timecop.freeze(Time.now)
      @session = build(:session, expires_at: nil)
    end

    after do
      Timecop.return
    end

    it 'should set token and expiration date' do
      expect(@session.expires_at).to be_nil
      expect(@session.token).to be_nil

      @session.validate

      expect(@session.expires_at).to eq Session::DEFAULT_EXPIRATION_TIME.from_now
      expect(@session.token).to be_truthy
    end
  end

  context 'user method' do
    before do
      @user = create(:user, password: '123456')
      @session = create(:session, resource: @user)
    end

    it 'should return user and contact for appropriate sessions' do
      expect(@session.resource).to be_kind_of(User)
    end
  end

  context 'expire' do
    before do
      Timecop.freeze(Time.now)
      @user = create(:user, password: '123456')
      @session = create(:session, resource: @user)
    end

    after do
      Timecop.return
    end

    it 'should return session if token is valid and not expired' do
      expect(@session.expires_at).to eq Session::DEFAULT_EXPIRATION_TIME.from_now
      expect(@session.token).to be_truthy

      @session.expire!

      expect(@session.expires_at).to eq Time.now
    end
  end
end
