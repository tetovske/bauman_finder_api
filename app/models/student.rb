class Student < ApplicationRecord
  belongs_to :form_of_study
  validates :first_name, :last_name, :id_stud, :id_abitur, presence: true
  validates :id_stud, uniqueness: true
end
