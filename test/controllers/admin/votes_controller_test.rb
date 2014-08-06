require 'test_helper'

class Admin::VotesControllerTest < ActionController::TestCase
  test "should get upvote" do
    get :upvote
    assert_response :success
  end

  test "should get downvote" do
    get :downvote
    assert_response :success
  end

end
