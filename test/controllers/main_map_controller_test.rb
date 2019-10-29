require 'test_helper'

class MainMapControllerTest < ActionDispatch::IntegrationTest
  test "should get map" do
    get main_map_map_url
    assert_response :success
  end

end
