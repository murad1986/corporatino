require 'test_helper'

class AbonentPaymentsControllerTest < ActionController::TestCase
  setup do
    @abonent_payment = abonent_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonent_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonent_payment" do
    assert_difference('AbonentPayment.count') do
      post :create, abonent_payment: @abonent_payment.attributes
    end

    assert_redirected_to abonent_payment_path(assigns(:abonent_payment))
  end

  test "should show abonent_payment" do
    get :show, id: @abonent_payment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonent_payment.to_param
    assert_response :success
  end

  test "should update abonent_payment" do
    put :update, id: @abonent_payment.to_param, abonent_payment: @abonent_payment.attributes
    assert_redirected_to abonent_payment_path(assigns(:abonent_payment))
  end

  test "should destroy abonent_payment" do
    assert_difference('AbonentPayment.count', -1) do
      delete :destroy, id: @abonent_payment.to_param
    end

    assert_redirected_to abonent_payments_path
  end
end
