require 'test_helper'

class MatchesFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    get root_path
    assert_response :success
    assert_select '.match-with-prediction', { count: 3 }
  end

  test 'first game shows all information' do
    get root_path
    assert_response :success
  end
end
