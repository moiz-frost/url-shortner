class CreateUrlViews < ActiveRecord::Migration[7.0]
  def change
    create_table :url_views do |t|
      t.references :url, index: true, null: false, foreign_key: true
      t.datetime :viewed_at, null: false
      t.string :ip
      t.string :referer
      t.string :user_agent

      t.timestamps
    end
  end
end
