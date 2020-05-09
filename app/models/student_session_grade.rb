class StudentSessionGrade < ApplicationRecord
  belongs_to :subject
  belongs_to :exam_grade
  belongs_to :student
end
