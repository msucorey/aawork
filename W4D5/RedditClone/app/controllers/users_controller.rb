class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.session_token
      redirect_to root_path #TODO
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_digest, :session_token)
  end

end

# Prefix Verb URI Pattern          Controller#Action
#  users POST /users(.:format)     users#create
# new_user GET  /users/new(.:format) users#new
