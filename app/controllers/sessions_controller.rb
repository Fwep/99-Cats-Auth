class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: :new
  
  def new
    @user = User.new
    @test = "hello"
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:session][:username], 
      params[:session][:password]
      )
    
    if @user
      login_user!(@user)
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      @user = User.new(
        username: params[:session][:username],
        password: params[:session][:password]
      )
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token]
      redirect_to cats_url
    end
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end