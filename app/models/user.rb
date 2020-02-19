# frozen_string_literal: true

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:vkontakte, :facebook, :github]

  validates :email, uniqueness: true
  validates :bf_api_token, uniqueness: true
  before_create :generate_token

  # updates jwt token
  def update_token
    BlackList.destroy_token(jwt_token)
    new_token = BlackList.generate_token(email)
    update(jwt_token: new_token)
  end

  # get token part for user
  def jwt_payload
    jwt_token.match(/\.(\w+\.\w+)/)[1]
  end

  # parse username from email
  def username
    email.match(/[^@]+/).to_s
  end

  # generates bf token for v1 api
  def generate_token
    begin
      token = Other::TokenGenerator.call(25).value_or("")
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

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
    
    def from_omniauth_facebook(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.bf_username = auth.info.name
        user.image_url = auth.info.image
      end
    end

    def from_omniauth_vk(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.email = auth.info.email
        user.password = Other::TokenGenerator.call(6).value_or("123456")
        user.image_url = auth.extra.raw_info.photo_400_orig
        user.bf_username = auth.info.name || "nameless"
      end
    end

    def from_omniauth_github(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.email = auth.info.email
        user.password = Other::TokenGenerator.call(6).value_or("123456")
      end
    end
  end
end
