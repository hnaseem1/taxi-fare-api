class SessionsController < ApplicationController
 before_action :user_already_logged_in, only: %i(new)
  def new
    render :new
  end

  def create
    
  	user_email = params[:session][:email]
  	user_password = params[:session][:password]
  	user = User.find_by(email: user_email)

  	if user && user.authenticate(user_password)
  		session[:user_id] = user.id
  		redirect_to user_path
  	elsif user_email == nil && user_password == nil || user_email == nil || user_password == nil
      flash[:error] = "enter login credentials"
  		render :new
    else 
      flash[:error] = "incorrect user name or password"
      render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
