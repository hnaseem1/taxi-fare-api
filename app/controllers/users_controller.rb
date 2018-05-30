class UsersController < ApplicationController
  before_action :user_already_logged_in, only: %i(new)
  before_action :ensure_logged_in, only: %i(show)

  def new
  	@user = User.new
  end

  def create
  	@user = User.new
  	@user.first_name = params[:user][:first_name]
  	@user.last_name = params[:user][:last_name]
  	@user.email = params[:user][:email]
  	@user.password = params[:user][:password]
  	@user.password_confirmation = params[:user][:password_confirmation]


  	if @user.save
      session[:user_id] = @user.id

      ##calling the mailer method when the user is saved without errors
      ##passing the user instance to the usermailer welcome_email method
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
  end
end
