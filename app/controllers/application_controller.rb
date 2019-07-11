class ApplicationController < ActionController::Base
  helper_method :current_user
  
  def current_user
    user = User.find_by(session_token: session[:session_token])
    user.nil? ? nil : user
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end
end
