# frozen_string_literal: true

module Api
  # UserController class
  class UserController < ApplicationController
    include Dry::Monads[:maybe]

    def create
      if @user = User.create_user(user_params)
        render :create, content_type: 'application/json'
      else
        render :json => { message: "user params is not valid!" }
      end
    end

    def destroy
      if user = check_admin(request.headers['token']).value_or(nil)
        User.where(user).first.destroy
        render json: { message: "user successfully deleted!" } 
      else
        render json: { message: "permission denied!" } 
      end
    end

    private 

    def user_params
      params.require('signup').permit('email', 'password', 'password_confirmation')
    end

    def check_admin(token)
      Maybe(BlackList.find_by_token(token)) do |user|
        return user if user.admin
      end
    end
  end
end