class StudentSemester < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :group, optional: true
  belongs_to :degree, optional: true
  belongs_to :semester_year, optional: true
  belongs_to :year, optional: true
  has_many :student_session_grades
  has_many :student_subject_grades
end
