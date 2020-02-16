# frozen_string_literal: true

# Application controller class
class ApplicationController < ActionController::Base
  layout 'application'
  skip_before_action :verify_authenticity_token
  before_action :language_set
  helper_method :users_in_db

  def language_set
    I18n.locale = params[:region] || I18n.default_locale
  end

  def default_url_options
    { region: I18n.locale }
  end

  def users_in_db
    Student.count
  end

  def after_sign_in_path_for(resource)
    # check for the class of the object to determine what type it is
    case resource.class.to_s
    when User.to_s
      account_path  
    else
      home_path
    end
  end
end
