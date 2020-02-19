class AdminController < ApplicationController
  include Devise
  before_action :check_admin, only: [:admin]
  
  def admin; end

  def destroy_user
    usr = User.find_by(id: params[:id])
    unless usr.nil?
      User.destroy(usr.id)
    end
    respond_to { |format| format.js }
  end

  def change_permissions
    usr = User.find_by(id: params[:id])
    unless usr.nil?
      usr.tap do |u|
        u.is_admin = !u.is_admin
        u.save!
      end
    end
    respond_to { |format| format.js }
  end

  private 

  def check_admin
    redirect_to home_path unless current_user.is_admin
  end
end
