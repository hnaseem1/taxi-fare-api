class ResetController < ApplicationController
  def show

  end

  def new
  	render :new
  end

  def create
  	@reset = Reset.new
  	@email = params[:reset][:email]
  	@user = User.find_by(email: @email)

  	if @user
  		@reset_hash = SecureRandom.hex(10)
  		@reset.user_id = @user.id
  		@reset.token = @reset_hash

  		if @reset.save
  			token = @reset.token
        @reset_url = "#{root_path}/reset/#{token}"

  			UserMailer.password_reset_email(@user, token, @reset_url)
        redirect_to pass_reset_path
  		end
  	end
  end

  def reset_pass
    @token = params[:reset][:token]  
    @reset_instance = Reset.find_by(token: @token)
    @password = params[:reset][:password]
    @user = @reset_instance.user_id

    if @token
      if  @user == @reset_instance.user_id
        change_user_pass = User.find(@user)
        change_user_pass.password =  @password
        change_user_pass.password_confirmation = @password
        change_user_pass.save
        p change_user_pass.errors.full_messages

      else 
        redirect_to new_resets_path
      end
    else 
      redirect_to new_resets_path
    end
  end
end
