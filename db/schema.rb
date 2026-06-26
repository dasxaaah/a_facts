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

ActiveRecord::Schema[8.1].define(version: 2026_06_26_115500) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.integer "article_type"
    t.text "body"
    t.string "category"
    t.string "cover_image"
    t.datetime "published_at"
    t.text "subcategories"
    t.string "subcategory"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "post_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contest_submissions", force: :cascade do |t|
    t.string "contest_slug", null: false
    t.datetime "created_at", null: false
    t.string "image", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["contest_slug"], name: "index_contest_submissions_on_contest_slug"
    t.index ["user_id"], name: "index_contest_submissions_on_user_id"
  end

  create_table "favourite_articles", force: :cascade do |t|
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "favourite_lessons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["lesson_id"], name: "index_favourite_lessons_on_lesson_id"
    t.index ["user_id", "lesson_id"], name: "index_favourite_lessons_on_user_id_and_lesson_id", unique: true
    t.index ["user_id"], name: "index_favourite_lessons_on_user_id"
  end

  create_table "favourite_posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "post_od"
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "glossary_terms", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "definition"
    t.string "term"
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.text "body"
    t.string "cover_image"
    t.datetime "created_at", null: false
    t.integer "lesson_number"
    t.string "module_name"
    t.string "title"
    t.datetime "updated_at", null: false
    t.string "video_url"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "likeable_id", null: false
    t.string "likeable_type", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["user_id", "likeable_type", "likeable_id"], name: "index_likes_on_user_id_and_likeable_type_and_likeable_id", unique: true
  end

  create_table "meetup_registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "meetup_slug", null: false
    t.datetime "meetup_starts_at"
    t.string "meetup_title", null: false
    t.string "meetup_url", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "meetup_slug"], name: "index_meetup_registrations_on_user_id_and_meetup_slug", unique: true
    t.index ["user_id"], name: "index_meetup_registrations_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "author"
    t.text "body"
    t.datetime "created_at", null: false
    t.string "post_image"
    t.integer "post_type", default: 1, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "kind", default: "text", null: false
    t.string "status", default: "draft", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["status"], name: "index_projects_on_status"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "quiz_questions", force: :cascade do |t|
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "option_d"
    t.text "question"
    t.integer "quiz_id", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.datetime "updated_at", null: false
  end

  create_table "tutorials", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_tutorials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", null: false
    t.string "name"
    t.string "nickname"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "users"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "contest_submissions", "users"
  add_foreign_key "favourite_lessons", "lessons"
  add_foreign_key "favourite_lessons", "users"
  add_foreign_key "meetup_registrations", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "quiz_questions", "quizzes"
  add_foreign_key "tutorials", "users"
end
