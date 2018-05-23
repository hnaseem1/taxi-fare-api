class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
	helper_method :current_user

  def getdata(start_lat,start_long,end_lat,end_long)

      # Hash for JSON database
      # JSON[KEY] = {"type", "distance", "fare", "currency", "duration"}

      @data = {:uber => [], :lyft => []}



      # keys
      uber_key = ENV['UBER_KEY']
      lyft_key = ENV['LYFT_KEY']


      uber_response = HTTParty.get("https://api.uber.com/v1.2/estimates/price?start_latitude=#{start_lat}&start_longitude=#{start_long}&end_latitude=#{end_lat}&end_longitude=#{end_long}",headers: {"Authorization" => "Token #{uber_key}"})

        uber_data = JSON.parse(uber_response.body)
          if uber_data["prices"]
              uber_data["prices"].each do |option|
                hash = {}
                hash["type"]      = option["localized_display_name"]
                hash["distance"]  = option["distance"]
                fare              = option["estimate"].split("$")[1].split('-') if option["estimate"].split("$")[1]
                hash["fare"]      = (fare[0].to_i + fare[1].to_i) / 2 if fare
                hash["currency"]  = option["currency_code"]
                hash["duration"]  = option["duration"]
                @data[:uber].push(hash)
              end
          else
            @data[:uber][0] = "UNVALID PARAMS"
          end


        # API calls to lyft for price estimates
        lyft_response = HTTParty.get("https://api.lyft.com/v1/cost?start_lat=#{start_lat}&start_lng=#{start_long}&end_lat=#{end_lat}&end_lng=#{end_long}",headers: {"Authorization" => "Basic #{lyft_key}"})

        lyft_data = JSON.parse(lyft_response.body)

        if lyft_data["cost_estimates"]
          lyft_data["cost_estimates"].each do |option|
            hash = {}
            hash["type"]      = option["display_name"]
            hash["distance"]  = option["estimated_distance_miles"]
            hash["fare"]      = (option["estimated_cost_cents_max"] + option["estimated_cost_cents_min"])/200
            hash["currency"]  = option["currency"]
            hash["duration"]  = option["estimated_duration_seconds"]
            @data[:lyft].push(hash)
          end
        else
          @data[:lyft][0] = "INVALID PARAMS"
        end

        # http://localhost:3000/price/show.json?sl=43.6549496&slon=-79.3759270&&el=43.6420997&&elon=-79.4402033

      @data



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
