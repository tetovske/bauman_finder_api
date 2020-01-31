# frozen_string_literal: true

# FormOfStudy model
class FormOfStudy < ApplicationRecord
  has_many :students
end
