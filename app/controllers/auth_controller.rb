# frozen_string_literal: true

# Authorization controller
class AuthController < ApplicationController
  include Dry::AutoInject(Container)[
    token_helper: 'other.token_manager'
  ]

  def create
    data = params[:user]
    user = User.find_by(email: data[:email])
    if user&.valid_password?(data[:password])
      token_data = { usr_id: user.id }
      token = token_helper.encode_key(token_data)
      render :json => {
        username: "#{user.email}",
        token: token
      }
    else
      render :json => { message: "unauthorized user!" }
    end
  end

  def destroy; end
  
  def auth; end

  def authorize_user
    usr = User.authenticate(params[:login], params[:pass])
    if usr.nil?
      redirect_to signin_url
    else
      session[:current_user_id] = usr.id
      redirect_to root_url
    end
  end

  def sign_out
    session[:current_user_id] = nil
    redirect_to signin_url
  end
end
