# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_17_123141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expires_at"], name: "index_auth_sessions_on_expires_at"
    t.index ["token", "expires_at"], name: "index_auth_sessions_on_token_and_expires_at"
    t.index ["user_id", "expires_at"], name: "index_auth_sessions_on_user_id_and_expires_at"
    t.index ["user_id"], name: "index_auth_sessions_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "value", null: false
    t.index ["value"], name: "index_categories_on_value", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "text", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id"
    t.index ["service_id"], name: "index_comments_on_service_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "short_name", null: false
    t.string "description", null: false
    t.string "logo_url", null: false
    t.string "address", null: false
    t.string "contact_phone", null: false
    t.string "background_img_url", null: false
    t.boolean "is_branch", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "parent_id"
    t.string "email"
    t.bigint "user_id"
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["parent_id"], name: "index_companies_on_parent_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_id"
    t.bigint "user_id"
    t.index ["service_id"], name: "index_ratings_on_service_id"
    t.index ["user_id", "service_id"], name: "index_user_id_service_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "service_categories", id: false, force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_service_categories_on_category_id"
    t.index ["service_id"], name: "index_service_categories_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_services_on_company_id"
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uuid"
    t.string "token"
    t.string "email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone", null: false
    t.string "photo_url", null: false
    t.boolean "is_consumer", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "password_digest"
    t.boolean "is_registered", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
