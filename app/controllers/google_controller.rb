class GoogleController < ApplicationController

  def index

    if params[:start_location] && params[:end_location] && !params[:start_location].blank? && !params[:end_location].blank?

      start_location  = params[:start_location]
      end_location    = params[:end_location]

      start_response_body = JSON.parse(get_maps_location(start_location).body)
      end_response_body   = JSON.parse(get_maps_location(end_location).body)

      # variables from the params

      sl        =   start_response_body['results'][0]["geometry"]['location']['lat'].to_s
      slon      =   start_response_body['results'][0]["geometry"]['location']['lng'].to_s
      el        =   end_response_body['results'][0]["geometry"]['location']['lat'].to_s
      elon      =   end_response_body['results'][0]["geometry"]['location']['lng'].to_s

      ##saving to the user/ride table

      if current_user
          
         searched_ride = Ride.new(latitude_start: sl, longitude_start: slon, latitude_end: el, longitude_end: elon, user_id: current_user.id, start_address: start_location, end_address: end_location)
         searched_ride.save

          ##email the user with the ride information. pass the ride instance to the mailer method( Currently commented out)

          # UserMailer.with(ride: ride, user: current_user).ride_info_email(current_user, ride).deliver_now

      end
    end

  end


  private

  def get_maps_location(cordinate)

    google_key=ENV["GOOGLE_KEY"]
    HTTParty.get(URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{cordinate}&key=#{google_key}"))

  end
end
