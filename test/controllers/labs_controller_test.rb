require 'test_helper'

class LabsControllerTest < ActionController::TestCase
  test "should get platform" do
    get :platform
    assert_response :success
  end

  test "should get helpdesk" do
    get :helpdesk
    assert_response :success
  end

  test "should get future" do
    get :future
    assert_response :success
  end

end
