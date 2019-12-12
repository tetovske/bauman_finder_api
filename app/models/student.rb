class Student < ApplicationRecord
  validates :name, :last_name, :group, presence: true
end
