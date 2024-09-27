class ExamGrade < ApplicationRecord
  has_many :student_session_grades
end
