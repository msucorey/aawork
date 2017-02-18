class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to root_path #TODO
    else
      flash[:errors] = ["sorry, invalid credentials"]
      redirect_to new_session_url
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:session_token] = nil
    render :new
  end

end

# Prefix Verb   URI Pattern            Controller#Action
#  users POST   /users(.:format)       users#create
# new_user GET    /users/new(.:format)   users#new
# session POST   /session(.:format)     sessions#create
# new_session GET    /session/new(.:format) sessions#new
#        DELETE /session(.:format)     sessions#destroy
