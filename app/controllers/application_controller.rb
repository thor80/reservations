class ApplicationController < ActionController::Base
  # Declaring here method as helper method, makes it available in every controller, so we can use it in any controller
  helper_method :current_user

  def current_user
    # If session[:user_id] is nil, set it to nil, otherwise find the user by id.
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
