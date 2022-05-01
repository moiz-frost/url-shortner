class CreateUserUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :user_urls do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :url, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
