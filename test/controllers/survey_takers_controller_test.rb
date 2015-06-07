require 'test_helper'

class SurveyTakersControllerTest < ActionController::TestCase
  setup do
    @survey_taker = survey_takers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:survey_takers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey_taker" do
    assert_difference('SurveyTaker.count') do
      post :create, survey_taker: { name: @survey_taker.name, number: @survey_taker.number }
    end

    assert_redirected_to survey_taker_path(assigns(:survey_taker))
  end

  test "should show survey_taker" do
    get :show, id: @survey_taker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @survey_taker
    assert_response :success
  end

  test "should update survey_taker" do
    patch :update, id: @survey_taker, survey_taker: { name: @survey_taker.name, number: @survey_taker.number }
    assert_redirected_to survey_taker_path(assigns(:survey_taker))
  end

  test "should destroy survey_taker" do
    assert_difference('SurveyTaker.count', -1) do
      delete :destroy, id: @survey_taker
    end

    assert_redirected_to survey_takers_path
  end
end
