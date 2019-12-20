class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :token, uniqueness: true

  class << self
    def create_user(params)
      user = User.new(
        email: params[:email],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      user.token = Other::JwtDecoder.call.encode_key(
        { 
          user_email: user.email,
          expires: Time.now + 5.hours.to_i
        }
      ).value!
      user.save if user.valid?
      user.valid? ? user : false
    end
  end
end
