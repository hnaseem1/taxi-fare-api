class SessionsController < ApplicationController
 before_action :user_already_logged_in, only: %i(new)
  def new
    render :new
  end

  def create
  	user = User.find_by(email_params)

  	if user && user.authenticate(password_params[:password])
  		session[:user_id] = user.id
  		redirect_to user_path

    elsif email_params == nil && password_params == nil || email_params == nil || password_params == nil
  		render :new

    else
      render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end

  private

  def email_params
    params.require(:session).permit(:email)
  end

  def password_params
    params.require(:session).permit(:password)
  end
end
