class Group < ApplicationRecord
  has_many :students
  validates :name, uniqueness: true
end
