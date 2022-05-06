# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_06_103046) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "key", null: false
    t.boolean "is_active", default: false, null: false
    t.boolean "is_deleted", default: false, null: false
    t.datetime "deleted_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_api_keys_on_deleted_at"
    t.index ["key"], name: "index_api_keys_on_key", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "resource_type", null: false
    t.bigint "resource_id", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.datetime "last_active_at"
    t.string "sign_in_ip"
    t.string "current_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_sessions_on_resource"
    t.index ["token"], name: "index_sessions_on_token", unique: true
  end

  create_table "url_views", force: :cascade do |t|
    t.bigint "url_id", null: false
    t.datetime "viewed_at", null: false
    t.string "ip"
    t.string "referer"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url_id"], name: "index_url_views_on_url_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "number"
    t.string "original"
    t.string "key"
    t.datetime "expires_at"
    t.string "resource_type"
    t.bigint "resource_id"
    t.integer "view_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_urls_on_key", unique: true
    t.index ["number"], name: "index_urls_on_number", unique: true
    t.index ["resource_type", "resource_id"], name: "index_urls_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "number"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "phone"
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["number"], name: "index_users_on_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "url_views", "urls"
end
