class UsersController < ApplicationController

  before_action :already_signed_in!

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]
    if @user.save
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      flash.now[:errors] = "invalid credentials"
      render :new
    end
  end



  private

  def user_params
    params.require(:user).permit(:user_name, :password_digest, :session_token, :password)
  end
end
