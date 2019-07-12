class ApplicationController < ActionController::Base
  helper_method :current_user, :user_can_approve
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

  def verify_cat_owner
    cats = current_user.cats.where(id: params[:id])

    redirect_to cats_url if cats.empty?
  end

  def user_can_approve
    cat_id = params[:id]
    cat_ids = current_user.cats.pluck(:id)
    cat_ids.include?(cat_id.to_i)
  end
end
