# frozen_string_literal: true

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :token, uniqueness: true
  before_create :generate_token

  def update_token
    BlackList.destroy_token(token)
    new_token = BlackList.generate_token(email)
    update(token: new_token)
  end

  def username
    email.match(/[^@]+/).to_s
  end

  def generate_token
    begin
      token = 1.upto(25).map { (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a)[rand(62)] }.join
    end until !User.where(token: token).nil?
    self.bf_api_token = token
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

    def from_omniauth(auth)
      # Either create a User record or update it based on the provider (Google) and the UID   
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.token = auth.credentials.token
        user.expires = auth.credentials.expires
        user.expires_at = auth.credentials.expires_at
        user.refresh_token = auth.credentials.refresh_token
      end
    end
  end
end
