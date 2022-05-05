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
class UrlView < ApplicationRecord
  include DelayedCountable

  belongs_to :url

  before_validation :set_viewed_at, on: :create, if: ->(i) { i.viewed_at.blank? }
  before_destroy :prevent_destroy

  counts :url, column: :view_count

  private

  def set_viewed_at
    self.viewed_at = Time.current
  end

  def prevent_destroy
    errors.add(:base, :undestroyable)
    throw :abort
  end
end
