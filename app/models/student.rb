# frozen_string_literal: true

# Student model
class Student < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :group_adm, class_name: 'Group', foreign_key: 'group_adm_id', optional: true
  belongs_to :form_of_study, optional: true
  belongs_to :degree, optional: true
  has_many :student_semesters

  validates :first_name, :last_name, :id_stud, presence: true
  validates :id_stud, uniqueness: true

  default_scope { order(exam_scores: :desc) }

  def gets_initials
    "#{last_name} #{first_name} #{mid_name}"
  end

  def gets_faculty
    group_adm.department.faculty
  end
end

# Working in progress
