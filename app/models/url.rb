# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  expires_at :datetime
#  long_url   :string
#  short_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_short_url  (short_url) UNIQUE
#
class Url < ApplicationRecord
end
