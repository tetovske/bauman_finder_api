class ApplicationController < ActionController::Base
  layout 'application'
  protect_from_forgery with: :null_session

  def authorize
    
  end
end
