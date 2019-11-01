require 'test_helper'

class ApiKeyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_key_index_url
    assert_response :success
  end

  test "should get new" do
    get api_key_new_url
    assert_response :success
  end

end
