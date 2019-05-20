require 'test_helper'

class AchievedBadgesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get achieved_badges_index_url
    assert_response :success
  end

end
