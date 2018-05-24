class ResetController < ApplicationController
  def show

  end

  def new
  	render :new
  end

  def create
  	@reset = Reset.new
  	@email = 
  end
end
