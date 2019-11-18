require 'test_helper'

class KotobasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kotoba = kotobas(:one)
  end

  test "should get index" do
    get kotobas_url
    assert_response :success
  end

  test "should get new" do
    get new_kotoba_url
    assert_response :success
  end

  test "should create kotoba" do
    assert_difference('Kotoba.count') do
      post kotobas_url, params: { kotoba: { message: @kotoba.message, word: @kotoba.word } }
    end

    assert_redirected_to kotoba_url(Kotoba.last)
  end

  test "should show kotoba" do
    get kotoba_url(@kotoba)
    assert_response :success
  end

  test "should get edit" do
    get edit_kotoba_url(@kotoba)
    assert_response :success
  end

  test "should update kotoba" do
    patch kotoba_url(@kotoba), params: { kotoba: { message: @kotoba.message, word: @kotoba.word } }
    assert_redirected_to kotoba_url(@kotoba)
  end

  test "should destroy kotoba" do
    assert_difference('Kotoba.count', -1) do
      delete kotoba_url(@kotoba)
    end

    assert_redirected_to kotobas_url
  end
end
