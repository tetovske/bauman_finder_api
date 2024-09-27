class Department < ApplicationRecord
  belongs_to :faculty, optional: true
  has_many :groups
end
