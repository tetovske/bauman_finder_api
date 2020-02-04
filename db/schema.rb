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

ActiveRecord::Schema.define(version: 2020_02_04_005456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "black_lists", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "form_of_studies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "mid_name"
    t.string "id_stud"
    t.string "id_abitur"
    t.decimal "exam_scores"
    t.integer "form_of_study_id"
    t.integer "group_adm_id"
    t.integer "group_id"
    t.integer "company_id"
    t.text "subject_data"
    t.index ["company_id"], name: "index_students_on_company_id"
    t.index ["form_of_study_id"], name: "index_students_on_form_of_study_id"
    t.index ["group_adm_id"], name: "index_students_on_group_adm_id"
    t.index ["group_id"], name: "index_students_on_group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bf_api_token"
    t.boolean "is_admin"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.boolean "expires"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "students", "companies"
  add_foreign_key "students", "form_of_studies"
  add_foreign_key "students", "groups"
  add_foreign_key "students", "groups", column: "group_adm_id"
end
