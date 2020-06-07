require 'test_helper'

class GlucoseLevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @glucose_level = glucose_levels(:one)
  end

  test "should get index" do
    get glucose_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_glucose_level_url
    assert_response :success
  end

  test "should create glucose_level" do
    assert_difference('GlucoseLevel.count') do
      post glucose_levels_url, params: { glucose_level: { observation_date: @glucose_level.observation_date, observations: @glucose_level.observations, user_id: @glucose_level.user_id } }
    end

    assert_redirected_to glucose_level_url(GlucoseLevel.last)
  end

  test "should show glucose_level" do
    get glucose_level_url(@glucose_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_glucose_level_url(@glucose_level)
    assert_response :success
  end

  test "should update glucose_level" do
    patch glucose_level_url(@glucose_level), params: { glucose_level: { observation_date: @glucose_level.observation_date, observations: @glucose_level.observations, user_id: @glucose_level.user_id } }
    assert_redirected_to glucose_level_url(@glucose_level)
  end

  test "should destroy glucose_level" do
    assert_difference('GlucoseLevel.count', -1) do
      delete glucose_level_url(@glucose_level)
    end

    assert_redirected_to glucose_levels_url
  end
end
