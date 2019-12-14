class Student < ApplicationRecord
  belongs_to :form_of_study
  validates :first_name, :last_name, :group_id, :id_stud, :id_abitur, presence: true
  validates :id_stud, :id_abitur, uniqueness: true
end
