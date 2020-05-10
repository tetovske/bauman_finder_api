class StudentSemester < ApplicationRecord
  belongs_to :student, optional: true
  belongs_to :group, optional: true
  belongs_to :degree, optional: true
  belongs_to :semester_year, optional: true
  belongs_to :year, optional: true
end
