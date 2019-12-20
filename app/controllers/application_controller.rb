class ApplicationController < ActionController::Base
  layout 'application'
  protect_from_forgery with: :null_session
  before_action :language_set, :authorize, except: %i[auth new create authorize_user]

  def language_set
    I18n.locale = params[:region] || I18n.default_locale
  end

  def default_url_options
    { region: I18n.locale }
  end

  def current_user
    @current_user ||= session[:current_user_id] &&
                      User.find_by(id: session[:current_user_id])
  end

  def authorize
    redirect_to signin_path unless current_user
  end
end
