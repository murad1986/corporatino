require 'test_helper'

class AbonentSaldosControllerTest < ActionController::TestCase
  setup do
    @abonent_saldo = abonent_saldos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonent_saldos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonent_saldo" do
    assert_difference('AbonentSaldo.count') do
      post :create, abonent_saldo: @abonent_saldo.attributes
    end

    assert_redirected_to abonent_saldo_path(assigns(:abonent_saldo))
  end

  test "should show abonent_saldo" do
    get :show, id: @abonent_saldo.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonent_saldo.to_param
    assert_response :success
  end

  test "should update abonent_saldo" do
    put :update, id: @abonent_saldo.to_param, abonent_saldo: @abonent_saldo.attributes
    assert_redirected_to abonent_saldo_path(assigns(:abonent_saldo))
  end

  test "should destroy abonent_saldo" do
    assert_difference('AbonentSaldo.count', -1) do
      delete :destroy, id: @abonent_saldo.to_param
    end

    assert_redirected_to abonent_saldos_path
  end
end
