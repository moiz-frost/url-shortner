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
require 'rails_helper'

RSpec.describe UserUrl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
