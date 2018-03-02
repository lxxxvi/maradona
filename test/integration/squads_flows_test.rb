require 'test_helper'

class SquadsFlowsTest < ActionDispatch::IntegrationTest
  test 'user creates a squad' do
    sign_in users(:diego)
    get root_path
    assert_select 'nav a', 'Squads'

    get squads_path
    assert_response :success

    assert_select '.btn.btn-primary', 'Create squad'
    post squads_path, params: {
      squad: {
        name: 'The Golden Boys'
      }
    }
    follow_redirect!
    assert_response :success

    assert_select 'h1', 'The Golden Boys'
    assert_select 'a.btn-default', 'Back'
  end
end
