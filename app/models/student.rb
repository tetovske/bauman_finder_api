class Student < ApplicationRecord
  belongs_to :group, :form_of_study
  belongs_to :company
  validates :first_name, :last_name, :id_stud, presence: true
  validates :id_stud, uniqueness: true
end
