# frozen_string_literal: true

require 'json'

module Api
  # module Api
  module V2
    # Authorization controller
    class AuthController < ApplicationController
      include Dry::Monads[:try, :maybe]
      include Dry::AutoInject(Container)[
        jwt: 'services.jwt_manager'
      ]

      def create
        if data = params['auth']
          @user = User.find_by(email: data['email'])
          if @user&.valid_password?(data['password'])
            @user.update_token
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
          BlackList.destroy_token(token)
          render json: { message: 'token successfully destroyed!' }
        else
          render json: { message: 'invalid params!' }
        end
      end
    end
  end
end
