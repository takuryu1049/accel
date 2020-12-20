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

ActiveRecord::Schema.define(version: 2020_12_04_013809) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.string "company_login_id", null: false
    t.string "post_code", null: false
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_login_id"], name: "index_companies_on_company_login_id", unique: true
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "owner_work_companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "company_name"
    t.string "company_name_kana"
    t.string "post_code"
    t.integer "prefecture_id"
    t.string "city"
    t.string "street"
    t.string "building_name"
    t.string "company_phone_num"
    t.string "job_description"
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_owner_work_companies_on_owner_id"
  end

  create_table "owners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "swicth_owner_form", default: "H", null: false
    t.string "company_name"
    t.string "company_name_kana"
    t.string "last_name"
    t.string "first_name"
    t.string "last_name_kana"
    t.string "first_name_kana"
    t.string "gender", default: "M"
    t.integer "character_id"
    t.text "character_about"
    t.string "post_code", null: false
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "building_name"
    t.string "main_communication", null: false
    t.text "communication_about", null: false
    t.string "home_phone_num"
    t.string "phone_num"
    t.string "other_phone_num"
    t.string "fax_num"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "properties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana", null: false
    t.string "post_code", null: false
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.integer "type_id", null: false
    t.integer "units", null: false
    t.integer "management_form_id", null: false
    t.integer "rank_id", null: false
    t.text "caution"
    t.bigint "company_id", null: false
    t.bigint "worker_id", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_properties_on_company_id"
    t.index ["owner_id"], name: "index_properties_on_owner_id"
    t.index ["worker_id"], name: "index_properties_on_worker_id"
  end

  create_table "resources", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "brokerage_fee", null: false
    t.integer "ad_fee", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "room_num"
    t.boolean "room_status", default: false
    t.integer "floor"
    t.bigint "property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_rooms_on_property_id"
  end

  create_table "utilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.integer "water_supply_id", null: false
    t.integer "sewer_id", null: false
    t.integer "electrical_id", null: false
    t.integer "ga_id", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_utilities_on_property_id"
  end

  create_table "workers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC", force: :cascade do |t|
    t.string "worker_login_id", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.boolean "gender", default: false, null: false
    t.date "born", null: false
    t.integer "character_id", null: false
    t.integer "position_id", null: false
    t.integer "qualification_id"
    t.bigint "company_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_workers_on_company_id"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
    t.index ["worker_login_id"], name: "index_workers_on_worker_login_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "owner_work_companies", "owners"
  add_foreign_key "properties", "companies"
  add_foreign_key "properties", "owners"
  add_foreign_key "properties", "workers"
  add_foreign_key "utilities", "properties"
  add_foreign_key "workers", "companies"
end
