class SetupFullDb < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        create_table :years do |t|
          t.integer :year
          t.timestamps
        end

        create_table :degrees do |t|
          t.string :title, limit: 10
          t.timestamps
        end

        create_table :semester_years do |t|
          t.references :year, foreign_key: true
          t.string :semester_title, :session_title, limit: 20
          t.integer :session_id
          t.timestamps
        end

        create_table :grade_types do |t|
          t.string :grade_type, limit: 20
          t.timestamps
        end

        create_table :subjects do |t|
          t.string :name, limit: 50
          t.timestamps
        end

        create_table :exam_grades do |t|
          t.string :grade, limit: 10
          t.timestamps
        end

        create_table :student_semesters do |t|
          t.references :student, :group, :semester_year, foreign_key: true
          t.references :admission_year, foreign_key: { to_table: :years }
          t.references :current_degree, foreign_key: { to_table: :degrees }
          t.timestamps
        end

        create_table :student_subject_grades do |t|
          t.references :student_semester, :subject, :grade_type, foreign_key: true
          t.integer :points
          t.timestamps
        end

        create_table :student_session_grades do |t|
          t.references :student_semester, :subject, :exam_grade, foreign_key: true
          t.timestamps
        end

        create_table :faculties do |t|
          t.string :name, limit: 30
          t.string :abbr, limit: 5
          t.timestamps
        end

        create_table :departments do |t|
          t.references :faculty, foreign_key: true
          t.string :name, limit: 30
          t.string :abbr, limit: 5
          t.timestamps
        end

        change_table :groups do |t|
          t.references :department, foreign_key: true
          t.string :abbr, limit: 5
        end

        change_table :students do |t|
          t.remove_references :group, foreign_key: true
          t.remove :subject_data
          t.references :degree, foreign_key: true
        end
      end

      dir.down do
        change_table :students do |t|
          t.remove_references :degree, foreign_key: true
          t.references :group, foreign_key: true
          t.string :subject_data
        end

        change_table :groups do |t|
          t.remove_references :department, foreign_key: true
          t.remove :abbr
        end

        drop_table :student_subject_grades
        drop_table :student_session_grades
        drop_table :student_semesters
        drop_table :semester_years
        drop_table :grade_types
        drop_table :subjects
        drop_table :exam_grades
        drop_table :departments
        drop_table :faculties
        drop_table :degrees
        drop_table :years
      end
    end
  end
end
