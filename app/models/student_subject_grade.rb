class StudentSubjectGrade < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :student_semester, optional: true
  belongs_to :grade_type, optional: true
end
