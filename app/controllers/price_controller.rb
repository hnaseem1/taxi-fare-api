class PriceController < ApplicationController

  # This controller acts whenever our api is called by the frontened

  def show

  # Endpoint of the api

  # /price/show?sl=43.6549496&slon=-79.3759257&&el=43.6920997&&elon=-79.5402031

  # gets the params values required to make thord-party api calls

  start_lat = params[:sl]
  start_long = params[:slon]
  end_lat = params[:el]
  end_long = params[:elon]

  # uses get_data method from the application controller to call the third-party apis

  data = get_data(start_lat,start_long,end_lat,end_long)

  # renders json to be used later in the app

  render json: data

  end
  
end
