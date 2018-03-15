require 'test_helper'

class RankingFlowsTest < ActionDispatch::IntegrationTest
  test 'visits ranking page' do
    user = users(:diego)
    sign_in user
    get ranking_path
    assert_response :success

    assert_select 'h1', 'Ranking'
    assert_select 'h2', 'Guys who know'
  end
end
