class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.string :key, null: false, index: { unique: true }

      t.boolean :is_active, default: false, null: false
      t.boolean :is_deleted, default: false, null: false
      t.datetime :deleted_at, index: true, null: true

      t.references :user, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
