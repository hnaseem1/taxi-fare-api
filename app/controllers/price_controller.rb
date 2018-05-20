require 'net/http'
require 'uri'

class PriceController < ApplicationController
  def show
  # Endpoint of the api

  # /price/show?sl=43.6549496&slon=-79.3759257&&el=43.6920997&&elon=-79.5402031

  start_lat = params[:sl]
  start_long = params[:slon]
  end_lat = params[:el]
  end_long = params[:elon]

  # Hash for JSON database
  # JSON[KEY] = {"type", "distance", "fare", "currency", "duration"}

  @data = {:uber => [], :lyft => []}



  # keys
  uber_key = ENV['UBER_KEY']
  lyft_key = ENV['LYFT_KEY']

  # API calls to uber for price estimation
  # keys for uber -  ["localized_display_name", "distance", "display_name", "product_id", "high_estimate", "low_estimate", "duration", "estimate", "currency_code"]

  uber_url = "https://api.uber.com/v1.2/estimates/price?start_latitude=#{start_lat}&start_longitude=#{start_long}&end_latitude=#{end_lat}&end_longitude=#{end_long}"

  uber_uri                        = URI.parse(uber_url)
  uber_request                    = Net::HTTP::Get.new(uber_uri)
  uber_request.content_type       = "application/json"
  uber_request["Authorization"]   = "Token #{uber_key}"
  uber_request["Accept-Language"] = "en_US"

  req_options = {
    use_ssl: uber_uri.scheme == "https",
  }

  uber_response = Net::HTTP.start(uber_uri.hostname, uber_uri.port, req_options) do |http|
    http.request(uber_request)
    end


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

    lyft_uri = URI.parse("https://api.lyft.com/v1/cost?start_lat=#{start_lat}&start_lng=#{start_long}&end_lat=#{end_lat}&end_lng=#{end_long}")
    lyft_request = Net::HTTP::Get.new(lyft_uri)
    lyft_request["Authorization"] = "Basic #{lyft_key}"

    req_options = {
      use_ssl: lyft_uri.scheme == "https",
    }

    lyft_response = Net::HTTP.start(lyft_uri.hostname, lyft_uri.port, req_options) do |http|
      http.request(lyft_request)
    end

    # Keys for lyft json ["ride_type", "estimated_duration_seconds", "estimated_distance_miles", "price_quote_id", "estimated_cost_cents_max", "primetime_percentage", "is_valid_estimate", "currency", "cost_token", "estimated_cost_cents_min", "display_name", "primetime_confirmation_token", "can_request_ride"]

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

    respond_to do |format|

        format.html
        format.json { render json: @data }

    end

  end
end
