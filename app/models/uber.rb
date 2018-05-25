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

          if option["localized_display_name"] == 'POOL'

            hash["type"]      = 'uberPOOL'

          else

            hash["type"]      = option["localized_display_name"]

          end

          hash["distance"]  = option["distance"]
          fare              = option["estimate"].split("$")[1].split('-') if option["estimate"].split("$")[1]

          if fare

            hash["fare"]      = (fare[0].to_i + fare[1].to_i) / 2
            hash["currency"]  = option["currency_code"]

          else

            hash["fare"]      = 'Metered'
            hash["currency"]  = ''

          end

          hash["duration"]  = option["duration"]
          hash["ETA"]       = Uber.get_eta(start_lat, start_long, option["localized_display_name"])

          data_array.push(hash)

          end

      else

        data_array[0] = "INVALID PARAMS"

      end

    # returning the required data in a form of meaningful data structure defined above
    return data_array

  end

  def self.get_eta(start_lat, start_long, type)

    uber_key = ENV['UBER_KEY']

    # endpoint
    api_endpoint = "https://api.uber.com/v1.2/estimates/time?start_latitude=#{start_lat}&start_longitude=#{start_long}"

    # response for ETA
    response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Token #{uber_key}"})

    # parsing data
    eta_data = JSON.parse(response.body)

    # finding the correct eta
    if eta_data["times"]

      eta_data["times"].each do |option|

        if option["localized_display_name"] == type

          return option["estimate"]

        end
      end
    else

    # throws an error if something goes wrong
        return "ETA Unavailable"

    end
  end

end
