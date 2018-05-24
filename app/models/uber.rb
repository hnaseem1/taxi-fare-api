class Uber < ApplicationRecord

  def self.get(start_lat,start_long,end_lat,end_long)

    # key for third-party api
    uber_key = ENV['UBER_KEY']

    # end point to GET price estimates
    api_endpoint = "https://api.uber.com/v1.2/estimates/price?start_latitude=#{start_lat}&start_longitude=#{start_long}&end_latitude=#{end_lat}&end_longitude=#{end_long}"

    # fetching response from api
    uber_response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Token #{uber_key}"})

    # parsing data to JSON
    uber_data = JSON.parse(uber_response.body)

    # data structure for returning values in a form of array of hashes
    data_array = []

    # some logic for sorting the api data into more readible and required information
      if uber_data["prices"]

        uber_data["prices"].each do |option|

          hash = {}

          hash["type"]      = option["localized_display_name"]
          hash["distance"]  = option["distance"]
          fare              = option["estimate"].split("$")[1].split('-') if option["estimate"].split("$")[1]
          hash["fare"]      = (fare[0].to_i + fare[1].to_i) / 2 if fare
          hash["currency"]  = option["currency_code"]
          hash["duration"]  = option["duration"]

          data_array.push(hash)

          end

      else

        data_array[0] = "UNVALID PARAMS"

      end

    # returning the required data in a form of meaningful data structure defined above
    return data_array

  end

end
