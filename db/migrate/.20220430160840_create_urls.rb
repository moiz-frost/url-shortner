# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls, &:timestamps
  end
end
