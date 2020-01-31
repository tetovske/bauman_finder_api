# frozen_string_literal: true

# Group model
class Group < ApplicationRecord
  has_many :students
  validates :name, uniqueness: true
end
