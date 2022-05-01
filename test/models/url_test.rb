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
require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
