class GradeType < ApplicationRecord
  has_many :student_subject_grades
end
