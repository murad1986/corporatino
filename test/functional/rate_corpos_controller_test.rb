require 'test_helper'

class RateCorposControllerTest < ActionController::TestCase
  setup do
    @rate_corpo = rate_corpos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rate_corpos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rate_corpo" do
    assert_difference('RateCorpo.count') do
      post :create, rate_corpo: @rate_corpo.attributes
    end

    assert_redirected_to rate_corpo_path(assigns(:rate_corpo))
  end

  test "should show rate_corpo" do
    get :show, id: @rate_corpo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rate_corpo.to_param
    assert_response :success
  end

  test "should update rate_corpo" do
    put :update, id: @rate_corpo.to_param, rate_corpo: @rate_corpo.attributes
    assert_redirected_to rate_corpo_path(assigns(:rate_corpo))
  end

  test "should destroy rate_corpo" do
    assert_difference('RateCorpo.count', -1) do
      delete :destroy, id: @rate_corpo.to_param
    end

    assert_redirected_to rate_corpos_path
  end
end
