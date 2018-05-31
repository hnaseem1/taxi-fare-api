class Uber < ApplicationRecord

  def self.get(start_lat,start_long,end_lat,end_long)

    # key for third-party api
    uber_key = ENV['UBER_KEY']

    # end point to GET price estimates
    api_endpoint = "https://api.uber.com/v1.2/estimates/price?start_latitude=#{start_lat}&start_longitude=#{start_long}&end_latitude=#{end_lat}&end_longitude=#{end_long}"

    # fetching response from api
    uber_response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Token #{uber_key}"})

    # fetching eta data from api_data
    eta_data = Uber.get_eta(start_lat, start_long)

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
            hash["capacity"]  = 2

          else

            hash["type"]      = option["localized_display_name"]

            if hash["type"] == 'uberXL' && hash["type"] == 'uberSUV'
              hash["capacity"] = 6

            else

              hash["capacity"] = 4

            end

          end

          hash["distance"]  = option["distance"]
          fare              = option["estimate"].split("$")[1].split('-') if option["estimate"].split("$")[1]
          hash["duration"]  = option["duration"]
          hash["eta"]       = Uber.find_eta(eta_data, option["localized_display_name"])

          if fare

            hash["fare"]      = (fare[0].to_i + fare[1].to_i) / 2
            hash["currency"]  = option["currency_code"]

          else

            fare = Uber.get_taxi(hash["distance"], hash["duration"])
            hash["fare"]      = fare.round
            hash["currency"]  = 'Metered, estimate'

          end

          data_array.push(hash)

          end



      else

        data_array[0] = "INVALID PARAMS"

      end

    # returning the required data in a form of meaningful data structure defined above
    return data_array

  end

  # method calls finds the eta using the type of ride
  def self.find_eta(data, type)

    # finding the correct eta
    if data["times"]

      data["times"].each do |option|

        if option["localized_display_name"] == type

          return option["estimate"]

        end
      end
    else
        # throws an error if something goes wrong
      return "ETA Unavailable"
    end
  end

  # method calls the eta data
  def self.get_eta(start_lat, start_long)

    uber_key = ENV['UBER_KEY']

    # endpoint
    api_endpoint = "https://api.uber.com/v1.2/estimates/time?start_latitude=#{start_lat}&start_longitude=#{start_long}"

    # response for ETA
    response = HTTParty.get(api_endpoint, headers: {"Authorization" => "Token #{uber_key}"})

    # parsing data
    eta_data = JSON.parse(response.body)

    # return data
    return eta_data

  end

  def self.get_taxi(distance, ride_time)

    base_fee = 4.25;
    per_km = 1.75;
    per_sec = 0.55/60.0
    cost = ((distance * per_km) + (per_sec * ride_time)) + base_fee;
    return cost

  end

end
