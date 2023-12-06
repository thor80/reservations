class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  # When user login, and password is right, then we store it in session
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Login failed"
      redirect_to login_path
    end
  end

  # To log out the user, we simply remove user from session cleaning it
  def destroy
    session.clear
    redirect_to login_path
  end
end
