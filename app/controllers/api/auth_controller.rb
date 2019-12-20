# frozen_string_literal: true

require 'json'

module Api
  # Authorization controller
  class AuthController < ApplicationController
    include Dry::Monads[:try]
    include Dry::AutoInject(Container)[
      jwt: 'other.token_manager'
    ]

    def create
      unless params[:email].nil? || params[:password].nil?
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          destroy_token(user.token)
          token = generate_token(user.email)
          user.update(token: token)
          render :json => {
            username: "#{user.email}",
            token: token
          }
        else
          render :json => { message: 'unauthorized user!' }
        end
      else
        render :json => { message: 'error' }
      end
    end

    def signout
      if token = params[:token]
        dec_token = jwt.call.decode_key(token).bind do |dec_token|
          if user = User.find_by(:email => dec_token['user_email'])
            msg = destroy_token(token) ? 'session destroyed!' : 'session already destroyed!'
            render :json => { message: msg }
          else
            render :json => { message: 'invalid token!' }
          end
        end
      else
        render :json => { message: 'invalid params!' }
      end
    end

    private 

    def destroy_token(token)
      rec = BlackList.new(token: token)
      if rec.valid?
        rec.save
        return true
      end
      false
    end

    def token_expired?(token)
      Try { jwt.call.decode_key(token) }
      .bind do |data|
        return false if (data['expires'].to_time - Time.now).positive?
        return true
      end
      true
    end

    def generate_token(user_email)
      data = {
        user_email: user_email,
        expires: Time.now + 1.hours.to_i
      }
      jwt.call.encode_key(data).value!
    end
  end
end
