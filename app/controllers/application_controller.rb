class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	helper_method :current_user

  def current_user
  	if session[:user_id]
  		@current_user ||= User.find(session[:user_id])
  	end
  end

  def user_already_logged_in
  	if session[:user_id] != nil
  		redirect_to user_path
  	end
  end

  def ensure_logged_in 
    if session[:user_id] == nil
      redirect_to root_path
    end 
  end
  
end
