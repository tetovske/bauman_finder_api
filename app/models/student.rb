# frozen_string_literal: true

# Student model
class Student < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :group, class_name: 'Group', foreign_key: 'group_id', optional: true
  belongs_to :group_adm, class_name: 'Group', foreign_key: 'group_id', optional: true
  belongs_to :form_of_study, optional: true
  validates :first_name, :last_name, :id_stud, presence: true
  validates :id_stud, uniqueness: true
end
