class StudentSessionGrade < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :exam_grade, optional: true
  belongs_to :student, optional: true
end
