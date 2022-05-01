# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url, index: { unique: true }
      t.datetime :expires_at
      t.references :resource, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
