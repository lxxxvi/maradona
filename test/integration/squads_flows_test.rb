require 'test_helper'

class SquadsFlowsTest < ActionDispatch::IntegrationTest
  test 'diego visits root page and sees his squads' do
    sign_in users(:diego)
    get authenticated_root_path
    assert_response :success

    squad_member_elements = css_select '.squad_members .squad_member'
    assert_equal 1, squad_member_elements.size
  end

  test 'zinedine visits root page and sees his squads ' do
    sign_in users(:zinedine)
    get authenticated_root_path
    assert_response :success

    squad_member_elements = css_select '.squad_members .squad_member'
    assert_equal 2, squad_member_elements.size
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
    get authenticated_root_path
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
    assert_select 'a', 'Back to your locker'
  end

  test 'squad coach edits a squad' do
    sign_in users(:diego)

    squad = squads(:fifa_100)

    get squad_path(squad)
    assert_response :success

    assert_select 'h1', 'Fifa 100'
    assert_select 'a', 'Edit'

    get edit_squad_path(squad)
    assert_response :success

    assert_select 'h1', 'Edit Fifa 100'
    assert_select 'form #squad_name'
    assert_select 'a', 'Back to squad'

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

  test 'koebi sees players ranking of CH Stars' do
    sign_in users(:koebi)

    squad = squads(:ch_stars)

    get squad_path(squad)
    assert_response :success

    assert_select 'h2', 'Players rankings'

    squad_member_elements = css_select('.squad-members .squad-member')

    element = squad_member_elements[0]
    assert_equal '1', element.css('.ci-user-ranking-position').text.strip
    assert_equal 'Chappi', element.css('.ci-user-nickname').text.strip
    assert_equal "2\n|\n0.0", element.css('.ci-user-stats').text.strip

    element = squad_member_elements[3]
    assert_equal '-', element.css('.ci-user-ranking-position').text.strip
    assert_equal 'Kubi', element.css('.ci-user-nickname').text.strip
    assert_equal "(Invited)", element.css('.ci-user-stats').text.strip
  end

  test 'squad stats' do
    sign_in users(:koebi)
    squad = squads(:ch_stars)
    squad_stats_h2_text = 'Squad stats'

    get squad_path(squad)
    assert_response :success

    assert_select 'h2', squad_stats_h2_text

    # simulate unstarted tournament
    assert Match.update_all(left_team_score: nil, right_team_score: nil).positive?

    get squad_path(squad)
    assert_response :success

    assert_select 'h2', text: squad_stats_h2_text, count: 0
  end

  test 'koebi sees shareable link' do
    sign_in users(:koebi)
    squad = squads(:ch_stars)

    get squad_path(squad)
    assert_response :success

    assert_select 'h3', 'Invitation link'
    invitation_link_input = css_find('input.invitation-link')
    assert_match 'ch-stars-invitation-key', invitation_link_input.attributes['value'].value
  end

  private

  def css_find(selektor)
    css_select(selektor)&.first
  end
end
