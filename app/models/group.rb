# frozen_string_literal: true

# Group model
class Group < ApplicationRecord
  has_many :students
  has_many :student_semesters
  has_many :semester_years, through: :student_semesters
  belongs_to :department, optional: true
  validates :name, uniqueness: true
end
