require 'test_helper'

class AbonentDebitsControllerTest < ActionController::TestCase
  setup do
    @abonent_debit = abonent_debits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:abonent_debits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create abonent_debit" do
    assert_difference('AbonentDebit.count') do
      post :create, abonent_debit: @abonent_debit.attributes
    end

    assert_redirected_to abonent_debit_path(assigns(:abonent_debit))
  end

  test "should show abonent_debit" do
    get :show, id: @abonent_debit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @abonent_debit.to_param
    assert_response :success
  end

  test "should update abonent_debit" do
    put :update, id: @abonent_debit.to_param, abonent_debit: @abonent_debit.attributes
    assert_redirected_to abonent_debit_path(assigns(:abonent_debit))
  end

  test "should destroy abonent_debit" do
    assert_difference('AbonentDebit.count', -1) do
      delete :destroy, id: @abonent_debit.to_param
    end

    assert_redirected_to abonent_debits_path
  end
end
