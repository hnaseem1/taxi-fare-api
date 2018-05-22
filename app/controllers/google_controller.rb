require 'httparty'

class GoogleController < ApplicationController



  def index
    if params[:start_location] && params[:end_location]


      google_key=ENV["GOOGLE_KEY"]

      @start_location= params[:start_location]
      @end_location= params[:end_location]

      google_start_location="https://maps.googleapis.com/maps/api/geocode/json?address=#{@start_location}&key=#{google_key}"
      google_end_location="https://maps.googleapis.com/maps/api/geocode/json?address=#{@end_location}&key=#{google_key}"

  # &components=country:CA


      start_response = HTTParty.get(google_start_location)
      @start_response_body = JSON.parse(start_response.body)
      end_response = HTTParty.get(google_end_location)
      @end_response_body = JSON.parse(end_response.body)

      sl = @start_response_body['results'][0]["geometry"]['location']['lat']
      slon = @start_response_body['results'][0]["geometry"]['location']['lng']
      el =  @end_response_body['results'][0]["geometry"]['location']['lat']
      elon = @end_response_body['results'][0]["geometry"]['location']['lng']

      taxi_fare_response = HTTParty.get("http://localhost:3000/price/show.json?sl=#{sl}&slon=#{slon}&el=#{el}&elon=#{elon}")
      @parsed_taxi_fare_response = JSON.parse(taxi_fare_response.body)

      
    else
      @start_response_body = nil
      @end_response_body = nil
    end



  end

  def position

    google_key=ENV["GOOGLE_KEY"]
  end

end
