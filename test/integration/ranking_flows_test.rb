require 'test_helper'

class RankingFlowsTest < ActionDispatch::IntegrationTest
  test 'visits ranking page' do
    user = users(:diego)
    user.update(ranking_position: 13)
    sign_in user
    get ranking_path
    assert_response :success

    assert_select 'h1', 'Ranking'
    assert_select 'h2', 'Global top 100'

    assert_select '.card .card-body' do
      assert_select '.card-subtitle', 'Your global ranking'
      assert_select '.card-title', '# 13'
    end
  end
end
