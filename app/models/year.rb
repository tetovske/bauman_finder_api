class Year < ApplicationRecord
  has_many :semester_years
  has_many :student_semesters
  has_many :groups, through: :student_semesters
end
