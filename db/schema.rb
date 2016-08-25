# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160825085741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audios", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uploaded_file"
    t.integer  "category_id",               null: false
    t.integer  "status",        default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "description"
    t.integer  "listens_count", default: 0
    t.integer  "likes_count",   default: 0
  end

  add_index "audios", ["category_id"], name: "index_audios_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",                           null: false
    t.text     "description"
    t.boolean  "limited_access", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "thumbnail"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "audio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "likes", ["audio_id"], name: "index_likes_on_audio_id", using: :btree
  add_index "likes", ["deleted_at"], name: "index_likes_on_deleted_at", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "listens", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "audio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "listens", ["audio_id"], name: "index_listens_on_audio_id", using: :btree
  add_index "listens", ["user_id"], name: "index_listens_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "phone"
    t.integer  "role",                   default: 0
    t.datetime "plan_expires_in"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "audios", "categories"
  add_foreign_key "likes", "audios"
  add_foreign_key "likes", "users"
  add_foreign_key "listens", "audios"
  add_foreign_key "listens", "users"
end
