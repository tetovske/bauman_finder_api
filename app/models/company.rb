class Company < ApplicationRecord
  validates :company_name, uniqueness: true
end
