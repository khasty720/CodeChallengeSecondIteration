class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #User Session Methods
  include SessionsHelper

  #Authenticate User before action
  def authenticate
    if user_signed_in == false
      redirect_to login_path, alert: 'Sign In Required'
    end
  end

end
