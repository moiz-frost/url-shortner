# frozen_string_literal: true

class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :key, index: { unique: true }
      t.datetime :expires_at
      t.references :resource, polymorphic: true, index: true
      t.integer :view_count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
