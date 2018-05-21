require 'test_helper'

class LandingPageFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page is shown for guest' do
    get landing_page_path
    assert_response :success

    assert_select 'h1', "Good you're here!"
    assert_select 'a', 'Tell me more...'
    assert_select 'a.btn-primary', 'Create account'
    assert_select 'a.btn-primary', 'Sign in'
  end

  test 'landing page is not shown for signed in user' do
    user = users(:diego)
    sign_in user

    get landing_page_path
    assert_response :success

    assert_select 'h1', 'Your locker'
  end
end
