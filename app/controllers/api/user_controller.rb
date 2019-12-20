# frozen_string_literal: true

module Api
  # UserController class
  class UserController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]

    # GET /users
    # GET /users.json
    def index
      @users = User.all
    end

    # GET /users/1
    # GET /users/1.json
    def show; end

    # GET /users/new
    def new
      @user = User.new
    end

    # GET /users/1/edit
    def edit; end

    def create
      user_params
      if user = User.create_user(params)
        render :json => { 
          message: "user successfully signed in!",
          user: user.to_json,
          token: user.token
        }
      else
        render :json => { message: "user params is not valid!" }
      end
    end

    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:email, :password, :password_confirmation, :format)
    end
  end
end