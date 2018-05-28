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
        Reset.generate_reset_token(@user)
        token = Reset.generate_reset_token(@user)
  			UserMailer.password_reset_email(@user, token, @reset_url).deliver_now
        redirect_to pass_reset_path
  	end
  end

  def reset_pass
    ##get the token from the params hash
    @token = params[:reset][:token]
    #if it exists
    if @token 
      @reset = Reset.find_by(token: @token)
      if @reset
        @user = User.find(@reset.user_id)
        @user.password =  params[:reset][:password]
        @user.password_confirmation = params[:reset][:password_confirmation]
        if @user.save
          @reset.token = "User Already Used This Token"
          @reset.save
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
