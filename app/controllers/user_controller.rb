class UserController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create 
    permit_data(params)
    if @user = User.create_user(params[:user])
      render :json => { message: "user created!" }
    else
      render :json => { message: "error while user creation!" }
    end
  end

  def destroy
    @user.destroy
  end

  def update
    @user.update(params)
  end

  private

  def set_user
    #@user = User.find_by()
  end

  def permit_data(data)
    params.require(:user)
      .permit(:email, :password, :password_confirmation)
  end
end
