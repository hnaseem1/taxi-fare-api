class ResetsController < ApplicationController
  def show

  end

  def new
  	render :new
  end

  def create
  	@email = params[:reset][:email]
    #search for user
  	@user = User.find_by(email: @email)
    #if user exists
  	if @user
        #get the token from the class method to sent to the user
        token = Reset.generate_reset_token(@user)
  			UserMailer.password_reset_email(@user, token).deliver_now
        redirect_to pass_reset_path
  	end
  end

  def reset_pass
    ##get the token from the params hash
    @token = params[:reset][:token]
    password = params[:reset][:password]
    password_confirmation = params[:reset][:password_confirmation]
    #if it exists
    if @token 
      if Reset.verify_user_requested_reset(@token)
        @user = Reset.verify_user_requested_reset(@token)
        @user = Reset.change_password(@user, password, password_confirmation)
        if @user.save
          Reset.exhaust_token(@token)

          UserMailer.password_reset_success_email(@user).deliver_now
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

end
