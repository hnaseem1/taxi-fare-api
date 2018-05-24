class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
	helper_method :current_user

  def getdata(start_lat,start_long,end_lat,end_long)

      # a structure for returning a JSON for our backend api
      # JSON[KEY] = {"type", "distance", "fare", "currency", "duration"}
      api_data = {:uber => [], :lyft => []}

      # API calls to uber for price estimates
      uber_data = Uber.get(start_lat,start_long,end_lat,end_long)

      # save it in a key of the data structure
      api_data[:uber] = uber_data

      # API calls to lyft for price estimates
      lyft_data = Lyft.get(start_lat,start_long,end_lat,end_long)

      # save it in a key of the data structure
      api_data[:lyft] = lyft_data

      #@data = uber_lyft_data_sorter(@data)
      return api_data
        # http://localhost:3000/price/show.json?sl=43.6549496&slon=-79.3759270&&el=43.6420997&&elon=-79.4402033
  end

  def sort_uber_and_lyft_prices(data)
    results = {uber: sort(data[:uber]),lyft: sort(data[:lyft])}

  end


  def sort(data)
    fares = data.map{ |a| a["fare"]}
    new_hash = {}
    fares.each_with_index do |f,i|
      new_hash[f]=data[i]
    end
    keysarry = new_hash.keys
    keysarry.delete(nil)
    results = []
    keysarry.sort.each do |k|
      results << new_hash[k]
    end

    results
  end

  def current_user
  	if session[:user_id]
  		@current_user ||= User.find(session[:user_id])
  	end
  end

  def user_already_logged_in
  	if session[:user_id] != nil
  		redirect_to user_path
  	end
  end

  def ensure_logged_in
    if session[:user_id] == nil
      redirect_to root_path
    end

  end

end
