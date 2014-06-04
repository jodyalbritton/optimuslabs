require 'test_helper'

class RateTypesControllerTest < ActionController::TestCase
  setup do
    @rate_type = rate_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rate_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rate_type" do
    assert_difference('RateType.count') do
      post :create, rate_type: { name: @rate_type.name, unit: @rate_type.unit }
    end

    assert_redirected_to rate_type_path(assigns(:rate_type))
  end

  test "should show rate_type" do
    get :show, id: @rate_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rate_type
    assert_response :success
  end

  test "should update rate_type" do
    patch :update, id: @rate_type, rate_type: { name: @rate_type.name, unit: @rate_type.unit }
    assert_redirected_to rate_type_path(assigns(:rate_type))
  end

  test "should destroy rate_type" do
    assert_difference('RateType.count', -1) do
      delete :destroy, id: @rate_type
    end

    assert_redirected_to rate_types_path
  end
end
