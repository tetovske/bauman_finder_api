class StudentSemester < ApplicationRecord
  belongs_to :student
  belongs_to :group
  belongs_to :degree
  belongs_to :semester_year
end
