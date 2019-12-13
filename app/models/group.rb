class Group < ApplicationRecord
  validates :name, uniqueness: true
end
