require 'test_helper'

class SquadsFlowsTest < ActionDispatch::IntegrationTest
  test 'diego visits root page and sees his squads' do
    sign_in users(:diego)
    get root_path
    assert_response :success

    squads_cards = css_select '.squads .card'
    assert_equal 1, squads_cards.size
  end

  test 'zinedine visits root page and sees his squads ' do
    sign_in users(:zinedine)
    get root_path
    assert_response :success

    squads_cards = css_select '.squads .card'
    assert_equal 2, squads_cards.size
  end

  test 'zinedine visits les_bleues and sees members by status' do
    squad = squads(:les_bleues)
    sign_in users(:zinedine)
    get squad_path(squad)
    assert_response :success

    assert_select '.squad-members-statuses button', 'Accepted'
    assert_select '.squad-members-statuses button', 'Invited'
    assert_select '.squad-members-statuses button', 'Rejected'

    assert_select '.accepted.squad-members-list .card', { count: 1 }
    assert_select '.invited.squad-members-list .card' , { count: 1 }
    assert_select '.rejected.squad-members-list .card', { count: 0 }
  end

  test 'diego visits squad where zinedine is the coach and he is not member' do
    sign_in users(:diego)
    les_bleues = squads(:les_bleues)
    get squad_path(les_bleues)
    assert_response :success

    assert_select 'h1', 'Les Bleues'
    assert_select 'a.btn', { text: 'Edit', count: 0 }, 'Diego should not see edit button for a foreign squad'
  end

  test 'zinedine visits squad where diego is the coach and he is member' do
    sign_in users(:zinedine)
    fifa_100 = squads(:fifa_100)
    get squad_path(fifa_100)
    assert_response :success

    assert_select 'h1', 'Fifa 100'
    assert_select 'a.btn', { text: 'Edit', count: 0 }, 'Zinedine should not see edit button because he is not the coach'
  end

  test 'diego creates new a squad' do
    sign_in users(:diego)
    get root_path
    assert_response :success
    assert_select 'a.btn-primary', 'Create new squad'

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

  test 'squad coach edits a squad' do
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
    assert_select 'a', 'Cancel'

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
