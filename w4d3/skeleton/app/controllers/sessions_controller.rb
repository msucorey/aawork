class SessionsController < ApplicationController

  before_action :already_signed_in!, except: [:destroy]

  def new
    render :new
  end

  def create
    login_user!
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end
    session[:session_token] = nil
    render :new
  end
end


# def create
#   @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
#   if @user
#     @user.reset_session_token
#     session[:session_token] = @user.session_token
#     redirect cats_url
#   else
#     flash.now[:errors] = "invalid credentials"
#     render :new
#   end
