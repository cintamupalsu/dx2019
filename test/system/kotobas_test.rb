require "application_system_test_case"

class KotobasTest < ApplicationSystemTestCase
  setup do
    @kotoba = kotobas(:one)
  end

  test "visiting the index" do
    visit kotobas_url
    assert_selector "h1", text: "Kotobas"
  end

  test "creating a Kotoba" do
    visit kotobas_url
    click_on "New Kotoba"

    fill_in "Message", with: @kotoba.message
    fill_in "Word", with: @kotoba.word
    click_on "Create Kotoba"

    assert_text "Kotoba was successfully created"
    click_on "Back"
  end

  test "updating a Kotoba" do
    visit kotobas_url
    click_on "Edit", match: :first

    fill_in "Message", with: @kotoba.message
    fill_in "Word", with: @kotoba.word
    click_on "Update Kotoba"

    assert_text "Kotoba was successfully updated"
    click_on "Back"
  end

  test "destroying a Kotoba" do
    visit kotobas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Kotoba was successfully destroyed"
  end
end
