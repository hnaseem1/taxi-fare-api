class ResetsController < ApplicationController
  before_action :reset_can_only_be_made_if_user_is_not_logged_in
  def show

  end

  def new
  	render :new
  end

  def create
    #finds user by email
  	user = User.find_by(email_params)
    #if user exists
  	if user
        #get the token from the class method to sent to the user
        token = Reset.generate_reset_token(user)
  			UserMailer.password_reset_email(user, token).deliver_now
        redirect_to pass_reset_path
  	end
  end

  def reset_pass    
    #if it exists
    if token_params
      if Reset.verify_user_requested_reset(token_params)
        user = Reset.verify_user_requested_reset(token_params)
        user = Reset.change_password(user, password_change_params[:password], password_change_params[:password_confirmation])

        if user.save
          Reset.exhaust_token(token_params)

          UserMailer.password_reset_success_email(user).deliver_now
          redirect_to new_sessions_path

        else
          redirect_to new_resets_path
        end
      else
        redirect_to new_resets_path
      end
    else
      redirect_to new_resets_path
    end
  end

  private 

  def reset_can_only_be_made_if_user_is_not_logged_in
    unless session[:user_id] == nil && !current_user
      redirect_to new_sessions_path
    end
  end

  def email_params
    params.require(:reset).permit(:email)
  end

  def token_params
    params.require(:reset).permit(:token)
  end

  def password_change_params
    params.require(:reset).permit(:password, :password_confirmation)
  end


end
