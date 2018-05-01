require 'test_helper'

class UsersFlowsTest < ActionDispatch::IntegrationTest
  test 'user sees ranking on show page' do
    user = users(:diego)
    user.update(ranking_position: 13)
    sign_in user

    get root_path

    assert_select '.ranking .ranking-position', '13'
    assert_select '.ranking .points-total', '20'
    assert_select '.ranking .points-match-average', '2.34'
  end

  test 'user sees how many predictions are missing' do
    user = users(:diego)

    sign_in user
    get root_path

    assert_select '.unpredicted_matches .card' do
      assert_select '.card-subtitle', 'Hurry!'
      assert_select '.card-title', 'You have 3 unpredicted matches'
      assert_select '.card-text a.btn.btn-primary', 'Predict them now!'
    end
  end
end
