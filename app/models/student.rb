class Student < ApplicationRecord
  validates :first_name, :last_name, :id_stud, presence: true
  validates :id_stud, uniqueness: true
end
