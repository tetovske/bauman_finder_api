class SemesterYear < ApplicationRecord
  belongs_to :year
  has_many :student_semesters
end
