class Api::SessionsController < ApplicationController

  def new
  end

  def create
    puts params
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    puts @user
    if @user
      sign_in(@user)
      render "api/users/show"
    else
      render json: ["Invalid credentials"], status: 437
    end
  end

  def destroy
    if current_user
      current_user.reset_token!
      session[:session_token] = nil
      render json: {}
    else
      render json: ['no user to log out'], status: 404
    end
  end

end
