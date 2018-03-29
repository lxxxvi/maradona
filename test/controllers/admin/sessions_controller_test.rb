require 'test_helper'

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'admin signs in' do
    get admin_sign_in_path
    assert_response :success

    sign_in_admin_with_password('wrong')
    assert_response :success
    assert_equal 'Invalid password', flash[:alert]

    sign_in_admin
    follow_redirect!
    assert_response :success
    assert_equal 'Signed in successfully.', flash[:notice]
  end

  test 'admin signs out' do
    sign_in_admin
    sign_out_admin
    follow_redirect!
    assert_response :success
    assert_equal 'Signed out successfully.', flash[:notice]
  end
end
