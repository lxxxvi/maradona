require 'test_helper'

class RankingFlowsTest < ActionDispatch::IntegrationTest
  test 'visits ranking page' do
    user = users(:diego)
    sign_in user
    get ranking_path
    assert_response :success

    assert_select 'h1', 'Global ranking'
    ranked_user_count = css_select('.ci-ranked-user').count
    assert ranked_user_count.positive?
  end
end
