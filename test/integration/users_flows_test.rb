require 'test_helper'

class UsersFlowsTest < ActionDispatch::IntegrationTest
  test 'user sees ranking on show page' do
    user = users(:diego)
    user.update(ranking_position: 13)
    sign_in user

    get root_path

    assert_select '.ranking .card .card-body' do
      assert_select '.card-subtitle', 'Global ranking'
      assert_select '.card-title', '# 13'
    end
  end

  test 'user sees how many predictions are missing' do
    user = users(:diego)

    sign_in user
    get root_path

    assert_select '.unpredicted_matches .card' do
      assert_select '.card-subtitle', 'Hurry!'
      assert_select '.card-title', 'You have 2 unpredicted matches'
      assert_select '.card-text a.btn.btn-success', 'Predict them now!'
    end
  end
end
