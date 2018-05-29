require 'test_helper'

class LyftTest < ActiveSupport::TestCase

  Cordinates = [43.6549496, -79.3759257, 43.6920997, -79.5402031]

  test "api response" do


    response = Lyft.get(Cordinates[0], Cordinates[1], Cordinates[2], Cordinates[3])
    assert response

  end

  test "api responding with ETA" do

    response = Lyft.get(Cordinates[0], Cordinates[1], Cordinates[2], Cordinates[3])
    assert response[0]["eta"]

  end

  test "response handling nil values" do

    cordinates = []
    response = Lyft.get(cordinates[0], cordinates[1], cordinates[2], cordinates[3])
    assert_equal(response[0], "INVALID PARAMS")

  end

  test "response handling string values" do

    cordinates = ["a", "b", "c", "d"]
    response = Lyft.get(cordinates[0], cordinates[1], cordinates[2], cordinates[3])
    assert_equal(response[0], "INVALID PARAMS")

  end

  test "get_eta giving back responses" do

    response = Lyft.get_eta(Cordinates[0], Cordinates[1])
    assert response

  end

  test "find_eta runs with valid parameters" do

    eta_data = Lyft.get_eta(Cordinates[0], Cordinates[1])
    type = "Lyft Lux"
    response = Lyft.find_eta(eta_data, type)
    assert response

  end

end
