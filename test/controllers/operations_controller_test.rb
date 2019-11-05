require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get operations_add_url
    assert_response :success
  end

  test "should get edit" do
    get operations_edit_url
    assert_response :success
  end

end
