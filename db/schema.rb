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

ActiveRecord::Schema.define(version: 2020_05_08_203620) do

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

  create_table "degrees", force: :cascade do |t|
    t.string "title", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "departments", force: :cascade do |t|
    t.bigint "faculty_id"
    t.string "name", limit: 30
    t.string "abbr", limit: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "exam_grades", force: :cascade do |t|
    t.string "grade", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "abbr", limit: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "form_of_studies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "grade_types", force: :cascade do |t|
    t.string "grade_type", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id"
    t.string "abbr", limit: 5
    t.index ["department_id"], name: "index_groups_on_department_id"
  end

  create_table "semester_years", force: :cascade do |t|
    t.bigint "year_id"
    t.string "semester_title", limit: 20
    t.string "session_title", limit: 20
    t.integer "session_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["year_id"], name: "index_semester_years_on_year_id"
  end

  create_table "student_semesters", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "group_id"
    t.bigint "semester_year_id"
    t.bigint "admission_year_id"
    t.bigint "current_degree_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["admission_year_id"], name: "index_student_semesters_on_admission_year_id"
    t.index ["current_degree_id"], name: "index_student_semesters_on_current_degree_id"
    t.index ["group_id"], name: "index_student_semesters_on_group_id"
    t.index ["semester_year_id"], name: "index_student_semesters_on_semester_year_id"
    t.index ["student_id"], name: "index_student_semesters_on_student_id"
  end

  create_table "student_session_grades", force: :cascade do |t|
    t.bigint "student_semester_id"
    t.bigint "subject_id"
    t.bigint "exam_grade_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_grade_id"], name: "index_student_session_grades_on_exam_grade_id"
    t.index ["student_semester_id"], name: "index_student_session_grades_on_student_semester_id"
    t.index ["subject_id"], name: "index_student_session_grades_on_subject_id"
  end

  create_table "student_subject_grades", force: :cascade do |t|
    t.bigint "student_semester_id"
    t.bigint "subject_id"
    t.bigint "grade_type_id"
    t.integer "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grade_type_id"], name: "index_student_subject_grades_on_grade_type_id"
    t.index ["student_semester_id"], name: "index_student_subject_grades_on_student_semester_id"
    t.index ["subject_id"], name: "index_student_subject_grades_on_subject_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mid_name"
    t.string "id_stud"
    t.string "id_abitur"
    t.decimal "exam_scores"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "form_of_study_id"
    t.bigint "group_adm_id"
    t.bigint "company_id"
    t.bigint "degree_id"
    t.index ["company_id"], name: "index_students_on_company_id"
    t.index ["degree_id"], name: "index_students_on_degree_id"
    t.index ["form_of_study_id"], name: "index_students_on_form_of_study_id"
    t.index ["group_adm_id"], name: "index_students_on_group_adm_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "years", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "departments", "faculties"
  add_foreign_key "groups", "departments"
  add_foreign_key "semester_years", "years"
  add_foreign_key "student_semesters", "degrees", column: "current_degree_id"
  add_foreign_key "student_semesters", "groups"
  add_foreign_key "student_semesters", "semester_years"
  add_foreign_key "student_semesters", "students"
  add_foreign_key "student_semesters", "years", column: "admission_year_id"
  add_foreign_key "student_session_grades", "exam_grades"
  add_foreign_key "student_session_grades", "student_semesters"
  add_foreign_key "student_session_grades", "subjects"
  add_foreign_key "student_subject_grades", "grade_types"
  add_foreign_key "student_subject_grades", "student_semesters"
  add_foreign_key "student_subject_grades", "subjects"
  add_foreign_key "students", "companies"
  add_foreign_key "students", "degrees"
  add_foreign_key "students", "form_of_studies"
  add_foreign_key "students", "groups", column: "group_adm_id"
end
