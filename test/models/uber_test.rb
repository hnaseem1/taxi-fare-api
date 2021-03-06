require 'test_helper'

class UberTest < ActiveSupport::TestCase

  Cordinates = [43.6549496, -79.3759257, 43.6920997, -79.5402031]

  test "api response" do

    response = Uber.get(Cordinates[0], Cordinates[1], Cordinates[2], Cordinates[3])
    assert response

  end

  test "api responding with ETA" do

    response = Uber.get(Cordinates[0], Cordinates[1], Cordinates[2], Cordinates[3])
    assert response[0]["eta"]

  end

  test "response handling nil values" do

    cordinates = []
    response = Uber.get(cordinates[0], cordinates[1], cordinates[2], cordinates[3])
    assert_equal(response[0], "INVALID PARAMS")

  end

  test "response handling string values" do

    cordinates = ["a", "b", "c", "d"]
    response = Uber.get(cordinates[0], cordinates[1], cordinates[2], cordinates[3])
    assert_equal(response[0], "INVALID PARAMS")

  end

  test "get_eta giving back responses" do

    response = Uber.get_eta(Cordinates[0], Cordinates[1])
    assert response

  end

  test "find_eta runs with valid parameters" do

    eta_data = Uber.get_eta(Cordinates[0], Cordinates[1])
    type = "UberSUV"
    response = Uber.find_eta(eta_data, type)
    assert response

  end

  test "checktype method" do

    type = "POOL"
    response = Uber.checktype(type)
    assert_equal(response, "UberPOOL")

  end

  test "checktype method edge case" do

    type = "Lanka"
    response = Uber.checktype(type)
    assert_equal(response, "Lanka")

  end

end
