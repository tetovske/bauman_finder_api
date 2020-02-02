# frozen_string_literal: true

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true

  def update_token
    BlackList.destroy_token(token)
    new_token = BlackList.generate_token(email)
    update(token: new_token)
  end

  def username
    email.match(/[^@]+/).to_s
  end

  class << self
    def create_user(params)
      user = User.new(
        email: params['email'],
        password: params['password'],
        password_confirmation: params['pasword_confirmation']
      )
      user.token = BlackList.generate_token(user.email)
      user.save if user.valid?
      user.valid? ? user : false
    end
  end
end
