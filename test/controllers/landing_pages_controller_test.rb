require 'test_helper'

class LandingPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Project Seal App"
  end

  test "should get home" do
    get landing_pages_home_url
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get help" do
    get landing_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get landing_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get landing_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
