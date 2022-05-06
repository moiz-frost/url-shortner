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
class Url < ApplicationRecord
  include Numerify
  include Expirable

  belongs_to :resource, polymorphic: true, optional: true

  has_many :url_views

  validates :key, uniqueness: true
  validates :original, :key, presence: true
  validates :original, http_url: true, if: ->(i) { i.original.present? }

  before_validation :decode_url

  alias_attribute :long, :original
  alias_attribute :short, :key

  scope :active, -> { where(Session.arel_table[:expires_at].gt(Time.current)) }

  private

  def decode_url
    self.original = Service::Url.decode original
  end
end
