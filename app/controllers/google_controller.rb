require 'httparty'

class GoogleController < ApplicationController


  def index
    if params[:search]

      google_key=ENV["GOOGLE_KEY"]
      @address=params[:search]
      google_geocoding_url="https://maps.googleapis.com/maps/api/geocode/json?address=#{@address}&key=#{google_key}"
  # &components=country:CA
      response = HTTParty.get(google_geocoding_url)
      @response_body = JSON.parse(response.body)
    else
      @response_body = nil
    end
  end

  def position

    google_key=ENV["GOOGLE_KEY"]
  end

end
