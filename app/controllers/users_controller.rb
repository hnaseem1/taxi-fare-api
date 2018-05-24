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
  	@user.match = ActiveRecord::Type::Boolean.new.cast(params[:user][:match])

  	if @user.save
      session[:user_id] = @user.id
  		redirect_to user_path
  	else 
  		render :new 
  	end
  end

  def show
	@user = current_user
    @match = current_user.match
  end
end
