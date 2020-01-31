# frozen_string_literal: true

require 'json'

# module Api
module Api
  # Authorization controller
  class AuthController < ApplicationController
    include Dry::Monads[:try, :maybe]
    include Dry::AutoInject(Container)[
      jwt: 'services.jwt_manager'
    ]

    def create
      if data = params['auth']
        usr = User.find_by(email: data['email'])
        if usr&.valid_password?(data['password'])
          usr.update_token
          @user = usr
          render :create, content_type: 'application/json'
        else
          render json: { message: 'unauthorized user!' }
        end
      else
        render json: { message: 'missing arguments!' }
      end
    end

    def signout
      if token = request.headers['token']
        Maybe(BlackList.find_by_token(token)).bind do |_user|
          msg = BlackList.destroy_token(token) ? 'token destroyed!' : 'token already destroyed!'
          render json: { message: msg }
        end
      else
        render json: { message: 'invalid params!' }
      end
    end
  end
end
