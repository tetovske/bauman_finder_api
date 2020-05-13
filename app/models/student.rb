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

  def gets_initials
    "#{last_name} #{first_name} #{mid_name}"
  end

  def tr_form_of_study
    puts "TEST" + form_of_study&.title
    case form_of_study&.title
    when "paid"
      "Платная"
    when "budget"
      "Бюджет"
    when "contract"
      "Целевая"
    end
  end
end

# Working in progress
