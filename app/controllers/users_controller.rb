class UsersController < ApplicationController
  before_action :user_already_logged_in, only: %i(new)
  before_action :ensure_logged_in, only: %i(show)

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(sign_up_params)
  	if @user.save
      session[:user_id] = @user.id
      UserMailer.welcome_email(@user).deliver_now
  		redirect_to user_path
  	else
  		render :new
  	end
  end

  def show
    @user = current_user
    ##to show the statistics for the user
    @user_favourite_rides = Ride.favourite_places(current_user)

    start_location = params[:start_location].to_s
    end_location = params[:end_location].to_s

    if start_location && end_location

      ride = Ride.new(user_id: current_user.id, start_address: start_location, end_address: end_location, ride_favourite: true)

      if ride.save
        redirect_to user_path
      end


    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
