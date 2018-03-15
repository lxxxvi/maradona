require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'can get show of own user' do
    user = users(:diego)

    sign_in user
    get user_path(user)
    assert_response :success
  end

  test 'can get show of other user' do
    user = users(:diego)
    other_user = users(:zinedine)

    sign_in user
    get user_path(other_user)
    assert_response :success
  end

  test 'cannot get show of user if not logged in' do
    user = users(:diego)
    get user_path(user)
    follow_redirect!
    assert_response :success
  end
end
