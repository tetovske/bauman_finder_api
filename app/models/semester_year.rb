class SemesterYear < ApplicationRecord
  belongs_to :year, optional: true
  has_many :student_semesters
end
