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

ActiveRecord::Schema[7.1].define(version: 2024_07_25_062448) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "music_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id"], name: "index_comments_on_music_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "music_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id"], name: "index_favorites_on_music_id"
    t.index ["user_id", "music_id"], name: "index_favorites_on_user_id_and_music_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "level_settings", force: :cascade do |t|
    t.integer "level"
    t.integer "threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memories", force: :cascade do |t|
    t.bigint "music_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "privacy", default: 0, null: false
    t.bigint "recommended_topic_id"
    t.index ["music_id"], name: "index_memories_on_music_id"
    t.index ["recommended_topic_id"], name: "index_memories_on_recommended_topic_id"
  end

  create_table "memory_tags", force: :cascade do |t|
    t.bigint "memory_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memory_id"], name: "index_memory_tags_on_memory_id"
    t.index ["tag_id"], name: "index_memory_tags_on_tag_id"
  end

  create_table "musics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "spotify_track_id"
    t.string "artist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience_point", default: 0
    t.integer "level", default: 1
    t.integer "favorites_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "memories_count", default: 0, null: false
    t.integer "privacy", default: 0, null: false
    t.index ["user_id"], name: "index_musics_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "recipient_id", null: false
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.boolean "unread", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
    t.index ["sender_id"], name: "index_notifications_on_sender_id"
  end

  create_table "recommended_topics", force: :cascade do |t|
    t.string "topic"
    t.boolean "current", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.text "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "avatar"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "comments", "musics"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "musics"
  add_foreign_key "favorites", "users"
  add_foreign_key "memories", "musics"
  add_foreign_key "memories", "recommended_topics"
  add_foreign_key "memory_tags", "memories"
  add_foreign_key "memory_tags", "tags"
  add_foreign_key "musics", "users"
  add_foreign_key "notifications", "users", column: "recipient_id"
  add_foreign_key "notifications", "users", column: "sender_id"
end
