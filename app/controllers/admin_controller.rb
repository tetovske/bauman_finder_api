# frozen_string_literal: true

class AdminController < ApplicationController
  include Devise
  before_action :check_admin, only: [:admin]
  REFRESH_USERS_JS = 'refresh_user_list.js.erb'

  def admin; end

  def destroy_user
    usr = User.find_by(id: params[:id])
    User.destroy(usr.id) unless usr.nil?
    respond_to { |format| format.js { render action: REFRESH_USERS_JS } }
  end

  def change_permissions
    usr = User.find_by(id: params[:id])
    usr&.tap do |u|
      u.is_admin = !u.is_admin
      u.save!
    end
    respond_to { |format| format.js { render action: REFRESH_USERS_JS } }
  end

  private

  def check_admin
    redirect_to home_path unless current_user.is_admin
  end
end
