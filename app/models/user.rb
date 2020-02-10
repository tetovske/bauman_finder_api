# frozen_string_literal: true

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:vkontakte, :facebook, :github]

  validates :email, uniqueness: true
  validates :bf_api_token, uniqueness: true
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
      puts "NEW USER SESSION: #{params}  SESSION: #{session}"
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
    
    def from_omniauth_facebook(auth)
      puts "FROM OMNIAUTH METHOD: #{auth.to_json}"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end

    def from_omniauth_vk(auth)
      puts "FROM OMNIAUTH METHOD: #{auth.to_json}"
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
      puts "from omni auth: #{auth}"
    end
  end
end
