require "application_system_test_case"

class TaskdetsTest < ApplicationSystemTestCase
  setup do
    @taskdet = taskdets(:one)
  end

  test "visiting the index" do
    visit taskdets_url
    assert_selector "h1", text: "Taskdets"
  end

  test "creating a Taskdet" do
    visit taskdets_url
    click_on "New Taskdet"

    fill_in "Content", with: @taskdet.content
    fill_in "Report", with: @taskdet.report_id
    fill_in "Status", with: @taskdet.status
    fill_in "User", with: @taskdet.user_id
    click_on "Create Taskdet"

    assert_text "Taskdet was successfully created"
    click_on "Back"
  end

  test "updating a Taskdet" do
    visit taskdets_url
    click_on "Edit", match: :first

    fill_in "Content", with: @taskdet.content
    fill_in "Report", with: @taskdet.report_id
    fill_in "Status", with: @taskdet.status
    fill_in "User", with: @taskdet.user_id
    click_on "Update Taskdet"

    assert_text "Taskdet was successfully updated"
    click_on "Back"
  end

  test "destroying a Taskdet" do
    visit taskdets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Taskdet was successfully destroyed"
  end
end
