class GoogleController < ApplicationController

  def index

    if params[:start_location] && params[:end_location]

      start_location= params[:start_location]
      end_location= params[:end_location]

      google_start_location = getMapsLocation(start_location)
      google_end_location   = getMapsLocation(end_location)

  # &components=country:CA


      start_response = HTTParty.get(google_start_location)
      start_response_body = JSON.parse(start_response.body)

      end_response = HTTParty.get(google_end_location)
      end_response_body = JSON.parse(end_response.body)

      sl        =   start_response_body['results'][0]["geometry"]['location']['lat'].to_s
      slon      =   start_response_body['results'][0]["geometry"]['location']['lng'].to_s
      el        =   end_response_body['results'][0]["geometry"]['location']['lat'].to_s
      elon      =   end_response_body['results'][0]["geometry"]['location']['lng'].to_s

      @parsed_taxi_fare_response = sort_uber_and_lyft_prices(getdata(sl,slon,el,elon))
       # taxi_fare_response = HTTParty.get("http://localhost:3000/price/show?sl=#{sl}&slon=#{slon}&el=#{el}&elon=#{elon}")


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
