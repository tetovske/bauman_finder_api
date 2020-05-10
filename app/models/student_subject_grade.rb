class StudentSubjectGrade < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :student, optional: true
  belongs_to :grade_type, optional: true
end
