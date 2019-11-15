require 'test_helper'

class ProgressesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get progresses_new_url
    assert_response :success
  end

  test "should get edit" do
    get progresses_edit_url
    assert_response :success
  end

end
