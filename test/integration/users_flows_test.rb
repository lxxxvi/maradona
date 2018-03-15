require 'test_helper'

class UsersFlowsTest < ActionDispatch::IntegrationTest
  test 'user sees ranking on show page' do
    user = users(:diego)
    user.update(ranking_position: 13)
    sign_in user

    get root_path

    assert_select '.card .card-body' do
      assert_select '.card-subtitle', 'Global ranking'
      assert_select '.card-title', '# 13'
    end
  end
end
