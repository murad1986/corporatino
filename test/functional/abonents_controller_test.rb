require 'test_helper'

class AbonentsControllerTest < ActionController::TestCase
  setup do
    @abonent = abonents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonent" do
    assert_difference('Abonent.count') do
      post :create, abonent: @abonent.attributes
    end

    assert_redirected_to abonent_path(assigns(:abonent))
  end

  test "should show abonent" do
    get :show, id: @abonent.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonent.to_param
    assert_response :success
  end

  test "should update abonent" do
    put :update, id: @abonent.to_param, abonent: @abonent.attributes
    assert_redirected_to abonent_path(assigns(:abonent))
  end

  test "should destroy abonent" do
    assert_difference('Abonent.count', -1) do
      delete :destroy, id: @abonent.to_param
    end

    assert_redirected_to abonents_path
  end
end
