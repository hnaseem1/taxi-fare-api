require 'test_helper'

class UberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "api response" do

    cordinates = [43.6549496, -79.3759257, 43.6920997, -79.5402031]
    response = Uber.get(cordinates[0], cordinates[1], cordinates[2], cordinates[3])
    assert response

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


end
