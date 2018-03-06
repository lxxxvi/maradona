require 'test_helper'

class SquadsFlowsTest < ActionDispatch::IntegrationTest
  test 'diego visits squads pages' do
    sign_in users(:diego)
    get squads_path
    assert_response :success

    squads_cards = css_select '.squads .card'
    assert_equal 1, squads_cards.size
  end

  test 'zinedine visits squads pages' do
    sign_in users(:zinedine)
    get squads_path
    assert_response :success

    squads_cards = css_select '.squads .card'
    assert_equal 2, squads_cards.size
  end

  test 'user creates a squad' do
    sign_in users(:diego)
    get root_path
    assert_select 'nav a', 'Squads'

    get squads_path
    assert_response :success
    assert_select 'a.btn-primary', 'Create Squad'

    get new_squad_path
    assert_response :success

    form_submit_button = css_find('form input[type=submit].btn.btn-primary')
    assert_equal 'Create Squad', form_submit_button.attr('value')
    assert_select 'form #squad_name'
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
    assert_select 'form #squad_name'
    assert_select 'a.btn-secondary', 'Cancel'

    form_submit_button = css_find('form input[type=submit].btn.btn-primary')
    assert_equal 'Update Squad', form_submit_button.attr('value')

    put squad_path(squad), params: {
      squad: {
        name: 'FIFA 100'
      }
    }

    follow_redirect!
    assert_response :success

    assert_select 'h1', 'FIFA 100'
  end

  private

  def css_find(selektor)
    css_select(selektor)&.first
  end
end
