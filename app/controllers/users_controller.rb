class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

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

  def edit_password
    if current_user.blank?
      redirect root_path
    end
    @user = current_user
  end

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

  def edit_profile
    if current_user.blank?
      redirect root_path
    end
    @user = current_user
  end

  def update_profile
    require 'fileutils'
    if current_user.blank?
      redirect root_path
    end

    @user = current_user

    @user.name = user_profile_params[:name]
    @user.introduction = user_profile_params[:introduction]

    icon_io = user_profile_params[:icon]
    icon_path = nil
    if icon_io
      icon_io.original_filename
      icon_path = Rails.root.join('public', 'uploads', @user.id.to_s, icon_io.original_filename)
      icon_path_resource = 'uploads/' + @user.id.to_s + "/" + icon_io.original_filename
    end

    if @user.update(name: user_profile_params[:name], introduction: user_profile_params[:introduction], icon: icon_path_resource)
      if icon_path
        FileUtils.mkdir_p Rails.root.join('public', 'uploads', @user.id.to_s)
        File.open(icon_path, 'wb') do |file|
          file.write(icon_io.read)
        end
      end
      redirect_to root_path, notice: 'Profile was successfully updated.'
    else
      flash[:alert] = "Profile hasn't been updated"
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_profile_params
    params.require(:user).permit(:name, :introduction, :icon)
  end

end
