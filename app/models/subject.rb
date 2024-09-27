class Subject < ApplicationRecord
  has_many :student_session_grades
  has_many :student_subject_grades
  has_many :students, through: :student_session_grades
end
