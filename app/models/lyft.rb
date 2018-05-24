class Lyft < ApplicationRecord

  def self.get(start_lat,start_long,end_lat,end_long)

    # key for third-party api
    lyft_key = ENV['LYFT_KEY']

    # end point to GET price estimates
    api_endpoint = "https://api.lyft.com/v1/cost?start_lat=#{start_lat}&start_lng=#{start_long}&end_lat=#{end_lat}&end_lng=#{end_long}"

    # fetching response from api
    lyft_response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Basic #{lyft_key}"})

    # parsing data to JSON
    lyft_data = JSON.parse(lyft_response.body)

    # data structure for returning values in a form of array of hashes
    data_array = []

    # some logic for sorting the api data into more readible and required information
    if lyft_data["cost_estimates"]

      lyft_data["cost_estimates"].each do |option|

        hash = {}

        hash["type"]      = option["display_name"]
        hash["distance"]  = option["estimated_distance_miles"]
        hash["fare"]      = (option["estimated_cost_cents_max"] + option["estimated_cost_cents_min"])/200
        hash["currency"]  = option["currency"]
        hash["duration"]  = option["estimated_duration_seconds"]

        data_array.push(hash)

      end

    else

      data_array[0] = "INVALID PARAMS"

    end

    # returning the required data in a form of meaningful data structure defined above
    return data_array

  end

end
