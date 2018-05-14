require 'net/http'
require 'uri'

class PriceController < ApplicationController
  def show
  # Endpoint of the api
  # start_lat=<START LATITUDE>&start_lng=<START LONGITUTE>8&end_lat=<END LATITUDE>&end_lng=<END LONGITUDE>
  @params = params[:id]

  # API calls to uber for price estimation

  uber_url = "https://api.uber.com/v1.2/estimates/price?start_latitude=37.7752315&start_longitude=-122.418075&end_latitude=37.7752415&end_longitude=-122.518075"
  uber_uri = URI.parse(uber_url)
  uber_request = Net::HTTP::Get.new(uber_uri)
  uber_request.content_type = "application/json"
  uber_request["Authorization"] = "Token <UBER-TOKEN>"
  uber_request["Accept-Language"] = "en_US"

  req_options = {
    use_ssl: uber_uri.scheme == "https",
  }

  uber_response = Net::HTTP.start(uber_uri.hostname, uber_uri.port, req_options) do |http|
    http.request(uber_request)
    end


    @uber_data = JSON.parse(uber_response.body)

    # API calls to lyft for price estimates

    lyft_uri = URI.parse("https://api.lyft.com/v1/cost?start_lat=37.7763&start_lng=-122.3918&end_lat=37.7972&end_lng=-122.4533")
    lyft_request = Net::HTTP::Get.new(lyft_uri)
    lyft_request["Authorization"] = "Basic <LYFT-TOKEN>"

    req_options = {
      use_ssl: lyft_uri.scheme == "https",
    }

    lyft_response = Net::HTTP.start(lyft_uri.hostname, lyft_uri.port, req_options) do |http|
      http.request(lyft_request)
    end

    @lyft_data = JSON.parse(lyft_response.body)

    # Parameters for the endpoints



  end
end
