ActiveRecord::Schema.define(version: 2020_02_16_122635) do

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
    t.string "email"
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
    t.string "jwt_token"
    t.string "refresh_token"
    t.integer "expires_at"
    t.boolean "expires"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "image_url"
    t.string "bf_username"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "students", "companies"
  add_foreign_key "students", "form_of_studies"
  add_foreign_key "students", "groups"
  add_foreign_key "students", "groups", column: "group_adm_id"
end
