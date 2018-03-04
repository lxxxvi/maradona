require 'test_helper'

class SquadsFlowsTest < ActionDispatch::IntegrationTest
  test 'user creates a squad' do
    sign_in users(:diego)
    get root_path
    assert_select 'nav a', 'Squads'

    get squads_path
    assert_response :success

    assert_select '.btn.btn-primary', 'Create squad'
    assert_select 'form input[type=text] .squad_name'
    assert_select 'form input[type=submit]'
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

  test 'squad admin edits a squad' do
    sign_in users(:diego)

    squad = squads(:fifa_100)

    get squad_path(squad)
    assert_response :success

    assert_select 'h1', 'Fifa 100'
    assert_select 'a.btn-secondary', 'Edit'

    get edit_squad_path(squad)
    assert_response :success

    assert_select 'h1', 'Edit Fifa 100'
    assert_select 'form input[type=text] .squad_name'
    assert_select 'a.btn-default', 'Cancel'
    assert_select 'form input[type=submit]', 'Update'

    post squad_path(squad), params: {
      squad: {
        name: 'FIFA 100'
      }
    }

    follow_redirect!
    assert_response :success

    assert_select 'h1', 'FIFA 100'
  end
end
