class BlackList < ApplicationRecord
  validates :token, uniqueness: true

  class << self
    def in_black_list?(token)
      return true unless find_by(:token => token).nil?
      false
    end
  end
end
