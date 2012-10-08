require 'test_helper'

class AbonentTarifsControllerTest < ActionController::TestCase
  setup do
    @abonent_tarif = abonent_tarifs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonent_tarifs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonent_tarif" do
    assert_difference('AbonentTarif.count') do
      post :create, abonent_tarif: @abonent_tarif.attributes
    end

    assert_redirected_to abonent_tarif_path(assigns(:abonent_tarif))
  end

  test "should show abonent_tarif" do
    get :show, id: @abonent_tarif.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonent_tarif.to_param
    assert_response :success
  end

  test "should update abonent_tarif" do
    put :update, id: @abonent_tarif.to_param, abonent_tarif: @abonent_tarif.attributes
    assert_redirected_to abonent_tarif_path(assigns(:abonent_tarif))
  end

  test "should destroy abonent_tarif" do
    assert_difference('AbonentTarif.count', -1) do
      delete :destroy, id: @abonent_tarif.to_param
    end

    assert_redirected_to abonent_tarifs_path
  end
end
