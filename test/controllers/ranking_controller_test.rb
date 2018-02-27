require 'test_helper'

class RankingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in users(:diego)
    get ranking_path
    assert_response :success
  end
end
