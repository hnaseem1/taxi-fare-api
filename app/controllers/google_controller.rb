class GoogleController < ApplicationController

  def index

    if params[:start_location] && params[:end_location] && !params[:start_location].blank? && !params[:end_location].blank?

      start_location  = params[:start_location]
      end_location    = params[:end_location]

      google_start_location = getMapsLocation(start_location)
      google_end_location   = getMapsLocation(end_location)

  # &components=country:CA

      begin
        start_response        = HTTParty.get(google_start_location)
        start_response_body   = JSON.parse(start_response.body)

        end_response        = HTTParty.get(google_end_location)
        end_response_body   = JSON.parse(end_response.body)

      rescue SocketError => e
        print e
        return false
      end

      sl        =   start_response_body['results'][0]["geometry"]['location']['lat'].to_s
      slon      =   start_response_body['results'][0]["geometry"]['location']['lng'].to_s
      el        =   end_response_body['results'][0]["geometry"]['location']['lat'].to_s
      elon      =   end_response_body['results'][0]["geometry"]['location']['lng'].to_s

      ##saving to the user/ride table

      if current_user


        # @sl = sl
        # @slon = slon
        # @el = el
        # @elon = elon
        # @start_location = start_location
        # @end_location = end_location
          fav_start = params[:fav_start]
          fav_end = params[:fav_end]

          if fav_start == 'true'
            ride = Ride.new(latitude_start: sl, longitude_start: slon, latitude_end: el, longitude_end: elon, user_id: current_user.id, start_address: start_location, end_address: end_location)
          end


          
          ride.save

      # if javascript gets disabled the app would still work using the controller method


          ##email the user with the ride information. pass the ride instance to the mailer method
          UserMailer.with(ride: ride, user: current_user).ride_info_email(current_user, ride).deliver_now
        else
          p 'something wrong'

        end


      # @parsed_taxi_fare_response = sort_uber_and_lyft_prices(getdata(sl,slon,el,elon))


    else

      # flash[:error] = 'Please Enter Something!'

    end
  end

  private

  def position

    google_key=ENV["GOOGLE_KEY"]

  end

  def getMapsLocation(cordinate)

    google_key=ENV["GOOGLE_KEY"]

    URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address=#{cordinate}&key=#{google_key}")

  end


end
