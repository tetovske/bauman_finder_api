class ApplicationController < ActionController::Base
  layout 'application'
  protect_from_forgery with: :null_session
  before_action :language_set

  def language_set
    I18n.locale = params[:region] || I18n.default_locale
  end

  def default_url_options
    { region: I18n.locale }
  end
end
