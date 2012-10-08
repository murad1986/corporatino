require 'test_helper'

class CorporationDebitsControllerTest < ActionController::TestCase
  setup do
    @corporation_debit = corporation_debits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corporation_debits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corporation_debit" do
    assert_difference('CorporationDebit.count') do
      post :create, corporation_debit: @corporation_debit.attributes
    end

    assert_redirected_to corporation_debit_path(assigns(:corporation_debit))
  end

  test "should show corporation_debit" do
    get :show, id: @corporation_debit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corporation_debit.to_param
    assert_response :success
  end

  test "should update corporation_debit" do
    put :update, id: @corporation_debit.to_param, corporation_debit: @corporation_debit.attributes
    assert_redirected_to corporation_debit_path(assigns(:corporation_debit))
  end

  test "should destroy corporation_debit" do
    assert_difference('CorporationDebit.count', -1) do
      delete :destroy, id: @corporation_debit.to_param
    end

    assert_redirected_to corporation_debits_path
  end
end
