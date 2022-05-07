# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe UrlView, type: :model do
end
