# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id            :bigint           not null, primary key
#  expires_at    :datetime
#  long_url      :string
#  resource_type :string
#  short_url     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_urls_on_resource   (resource_type,resource_id)
#  index_urls_on_short_url  (short_url) UNIQUE
#
class Url < ApplicationRecord
  belongs_to :resource, optional: true

  validates_uniqueness_of :short_url, :long_url

  scope :active, -> { where(Session.arel_table[:expires_at].gt(Time.current)) }
end
