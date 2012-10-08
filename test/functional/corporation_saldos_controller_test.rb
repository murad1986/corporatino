require 'test_helper'

class CorporationSaldosControllerTest < ActionController::TestCase
  setup do
    @corporation_saldo = corporation_saldos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporation_saldos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporation_saldo" do
    assert_difference('CorporationSaldo.count') do
      post :create, corporation_saldo: @corporation_saldo.attributes
    end

    assert_redirected_to corporation_saldo_path(assigns(:corporation_saldo))
  end

  test "should show corporation_saldo" do
    get :show, id: @corporation_saldo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporation_saldo.to_param
    assert_response :success
  end

  test "should update corporation_saldo" do
    put :update, id: @corporation_saldo.to_param, corporation_saldo: @corporation_saldo.attributes
    assert_redirected_to corporation_saldo_path(assigns(:corporation_saldo))
  end

  test "should destroy corporation_saldo" do
    assert_difference('CorporationSaldo.count', -1) do
      delete :destroy, id: @corporation_saldo.to_param
    end

    assert_redirected_to corporation_saldos_path
  end
end
