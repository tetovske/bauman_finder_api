# frozen_string_literal: true

# Black list class
class BlackList < ApplicationRecord
  extend RequestHandlers::TokenManager
  validates :token, uniqueness: true
end
