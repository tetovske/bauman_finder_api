# frozen_string_literal: true

# Company model
class Company < ApplicationRecord
  has_many :students
  validates :company_name, uniqueness: true
end
