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
class Session < ApplicationRecord
  include Expirable

  DEFAULT_EXPIRATION_TIME = 1.month.freeze

  belongs_to :resource, polymorphic: true

  validates :token, :expires_at, presence: true

  before_validation :set_token_and_expiration, on: :create

  scope :active, -> { where(Session.arel_table[:expires_at].gt(Time.current)) }

  private

  def set_token_and_expiration
    self.expires_at ||= DEFAULT_EXPIRATION_TIME.from_now
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Session.exists?(token: random_token) # can use bloom filter here for optimization
    end
  end
end
