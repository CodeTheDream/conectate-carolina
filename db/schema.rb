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

ActiveRecord::Schema.define(version: 2021_08_10_200941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "agencies", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "contact"
    t.string "phone"
    t.string "description"
    t.string "email"
    t.string "descripcion"
    t.string "mobile_phone"
    t.string "county"
    t.string "nombre"
    t.index ["name", "address", "city", "state", "zipcode"], name: "unique_index_on_agencies", unique: true
  end

  create_table "agency_categories", id: :serial, force: :cascade do |t|
    t.integer "agency_id"
    t.integer "category_id"
  end

  create_table "agency_update_requests", force: :cascade do |t|
    t.string "name"
    t.string "nombre"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "county"
    t.float "latitude"
    t.float "longitude"
    t.string "contact"
    t.string "phone"
    t.string "description"
    t.string "email"
    t.string "descripcion"
    t.string "mobile_phone"
    t.string "status", default: "submitted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "agency_id", null: false
    t.string "submitted_by", null: false
    t.string "submitter_email", null: false
    t.index ["agency_id"], name: "index_agency_update_requests_on_agency_id"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "categoria"
    t.string "fa_name"
  end

  create_table "device_messages", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "message_id", null: false
    t.string "ticket_id"
    t.string "status"
    t.json "error_messages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_device_messages_on_device_id"
    t.index ["message_id"], name: "index_device_messages_on_message_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "selected_lang"
  end

  create_table "faqs", id: :serial, force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.string "pregunta"
    t.text "respuesta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "posted", default: false
    t.string "message_type"
    t.string "titulo"
    t.text "cuerpo"
    t.datetime "posted_at"
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.integer "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "website_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
  end

  create_table "websites", id: :serial, force: :cascade do |t|
    t.integer "agency_id"
    t.integer "website_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["agency_id", "website_type_id", "url"], name: "index_websites_on_agencyId_websiteTypeId_and_url", unique: true
    t.index ["agency_id"], name: "index_websites_on_agency_id"
    t.index ["website_type_id"], name: "index_websites_on_website_type_id"
  end

  add_foreign_key "agency_categories", "agencies"
  add_foreign_key "agency_categories", "categories"
  add_foreign_key "device_messages", "devices"
  add_foreign_key "device_messages", "messages"
  add_foreign_key "agency_update_requests", "agencies"
  add_foreign_key "websites", "agencies"
  add_foreign_key "websites", "website_types"
end
