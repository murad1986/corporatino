require 'test_helper'

class CorporationPaymentsControllerTest < ActionController::TestCase
  setup do
    @corporation_payment = corporation_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporation_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporation_payment" do
    assert_difference('CorporationPayment.count') do
      post :create, corporation_payment: @corporation_payment.attributes
    end

    assert_redirected_to corporation_payment_path(assigns(:corporation_payment))
  end

  test "should show corporation_payment" do
    get :show, id: @corporation_payment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporation_payment.to_param
    assert_response :success
  end

  test "should update corporation_payment" do
    put :update, id: @corporation_payment.to_param, corporation_payment: @corporation_payment.attributes
    assert_redirected_to corporation_payment_path(assigns(:corporation_payment))
  end

  test "should destroy corporation_payment" do
    assert_difference('CorporationPayment.count', -1) do
      delete :destroy, id: @corporation_payment.to_param
    end

    assert_redirected_to corporation_payments_path
  end
end
