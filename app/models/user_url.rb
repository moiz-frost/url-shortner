# == Schema Information
#
# Table name: user_urls
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_urls_on_url_id   (url_id)
#  index_user_urls_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_44374f8208  (user_id => users.id)
#  fk_rails_6f90b560b4  (url_id => urls.id)
#
class UserUrl < ApplicationRecord
  belongs_to :user
  belongs_to :url

  validates :user_id, :url_id, presence: true
end
