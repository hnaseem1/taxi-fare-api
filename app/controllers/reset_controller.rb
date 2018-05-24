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
  			#@reset_url = 
  			token = @reset.token
  			#UserMailer.password_reset_email(@user, token, @reset_url)
  		end
  	end
  end
end
