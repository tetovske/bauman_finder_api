class BlackList < ApplicationRecord
  extend RequestHandlers::TokenManager
  validates :token, uniqueness: true
end
