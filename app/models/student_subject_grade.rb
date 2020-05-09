class StudentSubjectGrade < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :grade_type
end
