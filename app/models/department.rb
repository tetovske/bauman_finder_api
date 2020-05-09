class Department < ApplicationRecord
  belongs_to :faculty
  has_many :groups
end
