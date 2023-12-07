class UsersController < ApplicationController

  # This list all users, but is not linked to any view at this time
  def index
    @users = User.all
  end

  # Prepare new user form
  def new
    @user = User.new
  end

  # Create new user and go to index
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to root_path
    else
      flash[:alert] = "User not created"
      render :new, status: :unprocessable_entity
    end
  end

  # Prepare view for user password edit form
  def edit_password
    if current_user.blank?
      redirect root_path
    end
    @user = current_user
  end

  # Update user password
  def update_password
    if current_user.blank?
      redirect root_path
    end
    @user = current_user
    if @user.update(user_password_params)
      redirect_to root_path, notice: 'Password was successfully updated.'
    else
      flash[:alert] = "Password hasn't been updated"
      render :edit_password, status: :unprocessable_entity
    end
  end

  # Init user profile form
  def edit_profile
    if current_user.blank?
      redirect root_path
    end
    @user = current_user
  end

  # Update profile for user
  def update_profile
    require 'fileutils'
    if current_user.blank?
      redirect root_path
    end

    @user = current_user

    if @user.update(user_profile_params)
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      flash[:alert] = "Profile hasn't been updated"
      render :edit_profile, status: :unprocessable_entity
    end
  end

  # Here methods to extract parameters that will be used in different forms
  private

  # To create new user we need this parameters
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # To change password we need this parameters
  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # To change user profile we need this parameters
  def user_profile_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end
