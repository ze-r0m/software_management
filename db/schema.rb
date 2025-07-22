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

ActiveRecord::Schema[8.0].define(version: 2025_07_22_094544) do
  create_table "cafedras", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "add_note"
    t.bigint "faculty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cafedras_on_deleted_at"
    t.index ["faculty_id"], name: "index_cafedras_on_faculty_id"
    t.index ["name"], name: "index_cafedras_on_name", unique: true
  end

  create_table "class_softwares", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "comp_class_id", null: false
    t.bigint "installed_software_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comp_class_id", "installed_software_id"], name: "index_class_software_unique", unique: true
    t.index ["comp_class_id"], name: "index_class_softwares_on_comp_class_id"
    t.index ["installed_software_id"], name: "index_class_softwares_on_installed_software_id"
  end

  create_table "comp_classes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "aud_number", null: false
    t.integer "count_seat"
    t.integer "count_comp_seat"
    t.integer "count_comp"
    t.text "spec_purpose"
    t.boolean "projector"
    t.boolean "panel"
    t.boolean "ch_board"
    t.text "add_note"
    t.bigint "cafedra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["aud_number"], name: "index_comp_classes_on_aud_number", unique: true
    t.index ["cafedra_id"], name: "index_comp_classes_on_cafedra_id"
    t.index ["deleted_at"], name: "index_comp_classes_on_deleted_at"
  end

  create_table "faculties", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "add_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_faculties_on_deleted_at"
    t.index ["name"], name: "index_faculties_on_name", unique: true
  end

  create_table "installed_softwares", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "version"
    t.date "start_date"
    t.date "finish_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "keyholder"
    t.boolean "is_server", default: false
    t.string "note", limit: 8
    t.integer "quantity"
    t.string "usage_basis"
    t.text "purpose"
  end

  create_table "request_soft_auds", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "request_soft_id", null: false
    t.bigint "comp_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comp_class_id"], name: "index_request_soft_auds_on_comp_class_id"
    t.index ["request_soft_id", "comp_class_id"], name: "index_request_soft_auds_unique", unique: true
    t.index ["request_soft_id"], name: "index_request_soft_auds_on_request_soft_id"
  end

  create_table "request_softs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "soft_name", null: false
    t.string "version", null: false
    t.integer "count", null: false
    t.decimal "price", precision: 10, scale: 2
    t.text "contact"
    t.bigint "cafedra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cafedra_id"], name: "index_request_softs_on_cafedra_id"
  end

  create_table "roles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "cafedras", "faculties"
  add_foreign_key "class_softwares", "comp_classes"
  add_foreign_key "class_softwares", "installed_softwares"
  add_foreign_key "comp_classes", "cafedras"
  add_foreign_key "request_soft_auds", "comp_classes"
  add_foreign_key "request_soft_auds", "request_softs"
  add_foreign_key "request_softs", "cafedras"
  add_foreign_key "users", "roles"
end
