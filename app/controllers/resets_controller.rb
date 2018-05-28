class ResetsController < ApplicationController

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

  			UserMailer.password_reset_email(@user, token, @reset_url).deliver_now
        redirect_to pass_reset_path
  		end
  	end
  end

  def reset_pass
    @token = params[:reset][:token]

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
