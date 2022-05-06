# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :number, index: { unique: true }

      t.string :first_name
      t.string :last_name
      t.string :username, index: { unique: true }
      t.string :phone

      ## Database authenticatable
      t.string :email,              null: false, index: { unique: true }
      t.string :encrypted_password, null: false

      ## Recoverable
      t.string   :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      t.timestamps null: false
    end
  end
end
