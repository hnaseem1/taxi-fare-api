class RideiconsController < ApplicationController
  def show
    if params[:start_lat] && params[:start_lng]

      start_lat = params[:start_lat]
      start_lng = params[:start_lng]

      lyft_eta_key = ENV['LYFT_ETA_KEY']

      # endpoint
      api_endpoint = "https://api.lyft.com/v1/drivers?lat=#{start_lat}&lng=#{start_lng}"

      # response for drivers location
      response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Bearer #{lyft_eta_key}"})

      # parsing data
      drivers_location = JSON.parse(response.body)
      data = []

      if drivers_location['error'] != "no_service_in_area"
      drivers_location["nearby_drivers"].each do |hash|
          hash["drivers"].each do |location|
            data.push([location["locations"][0]["lat"], location["locations"][0]["lng"]])
        end
      end
    end

      render json: data
    end
  end
end
