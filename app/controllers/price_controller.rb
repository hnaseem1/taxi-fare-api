class PriceController < ApplicationController
  def show
  # Endpoint of the api

  # /price/show?sl=43.6549496&slon=-79.3759257&&el=43.6920997&&elon=-79.5402031

  start_lat = params[:sl]
  start_long = params[:slon]
  end_lat = params[:el]
  end_long = params[:elon]
  data = getdata(start_lat,start_long,end_lat,end_long)

  render json: data


  end
  
end
