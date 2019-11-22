require 'test_helper'

class TaskdetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taskdet = taskdets(:one)
  end

  test "should get index" do
    get taskdets_url
    assert_response :success
  end

  test "should get new" do
    get new_taskdet_url
    assert_response :success
  end

  test "should create taskdet" do
    assert_difference('Taskdet.count') do
      post taskdets_url, params: { taskdet: { content: @taskdet.content, report_id: @taskdet.report_id, status: @taskdet.status, user_id: @taskdet.user_id } }
    end

    assert_redirected_to taskdet_url(Taskdet.last)
  end

  test "should show taskdet" do
    get taskdet_url(@taskdet)
    assert_response :success
  end

  test "should get edit" do
    get edit_taskdet_url(@taskdet)
    assert_response :success
  end

  test "should update taskdet" do
    patch taskdet_url(@taskdet), params: { taskdet: { content: @taskdet.content, report_id: @taskdet.report_id, status: @taskdet.status, user_id: @taskdet.user_id } }
    assert_redirected_to taskdet_url(@taskdet)
  end

  test "should destroy taskdet" do
    assert_difference('Taskdet.count', -1) do
      delete taskdet_url(@taskdet)
    end

    assert_redirected_to taskdets_url
  end
end
