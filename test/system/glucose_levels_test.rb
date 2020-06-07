require "application_system_test_case"

class GlucoseLevelsTest < ApplicationSystemTestCase
  setup do
    @glucose_level = glucose_levels(:one)
  end

  test "visiting the index" do
    visit glucose_levels_url
    assert_selector "h1", text: "Glucose Levels"
  end

  test "creating a Glucose level" do
    visit glucose_levels_url
    click_on "New Glucose Level"

    fill_in "Observation date", with: @glucose_level.observation_date
    fill_in "Observations", with: @glucose_level.observations
    fill_in "User", with: @glucose_level.user_id
    click_on "Create Glucose level"

    assert_text "Glucose level was successfully created"
    click_on "Back"
  end

  test "updating a Glucose level" do
    visit glucose_levels_url
    click_on "Edit", match: :first

    fill_in "Observation date", with: @glucose_level.observation_date
    fill_in "Observations", with: @glucose_level.observations
    fill_in "User", with: @glucose_level.user_id
    click_on "Update Glucose level"

    assert_text "Glucose level was successfully updated"
    click_on "Back"
  end

  test "destroying a Glucose level" do
    visit glucose_levels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Glucose level was successfully destroyed"
  end
end
