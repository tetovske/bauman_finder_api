class Degree < ApplicationRecord
  has_many :students
  has_many :student_semesters
end
