# frozen_string_literal: true

require 'digest'

# User model
class User < ApplicationRecord
  validates :login, uniqueness: true

  class << self
    def authenticate(login, pass)
      usr = User.find_by(email: login)
      return nil if usr.nil?
      return usr if usr.check_passw?(pass)
    end

    def create_user(params)
      data = params[:user]
      hash = Digest::SHA256.hexdigest(data[:pass])
      hash_d = Digest::SHA256.hexdigest(data[:pass_d])
      return User.new unless hash == hash_d

      create(email: data[:login], password: hash)
    end
  end

  def check_passw?(password)
    password_digest == Digest::SHA256.hexdigest(password)
  end
end
