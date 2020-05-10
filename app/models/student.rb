# frozen_string_literal: true

# Student model
class Student < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :group_adm, class_name: 'Group', foreign_key: 'group_adm_id', optional: true
  belongs_to :form_of_study, optional: true
  belongs_to :degree, optional: true
  has_many :student_semesters
  has_many :student_session_grades
  has_many :student_subject_grades
  has_many :subjects, through: :student_session_grades
  has_many :exam_grades, through: :student_session_grades

  validates :first_name, :last_name, :id_stud, presence: true
  validates :id_stud, uniqueness: true
end

# Working in progress
