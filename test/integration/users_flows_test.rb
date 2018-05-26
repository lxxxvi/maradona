require 'test_helper'

class UsersFlowsTest < ActionDispatch::IntegrationTest
  test 'user sees ranking on show page during the world cup' do
    user = users(:diego)
    other_user = users(:zinedine)
    user.update(ranking_position: 13)
    sign_in user

    your_stats_h2_text = 'Your stats'
    stats_h2_text = 'Stats'

    travel_to during_the_world_cup do
      get authenticated_root_path
      assert_response :success
      assert_select 'h2', { text: your_stats_h2_text, count: 1 }

      assert_select '.ranking .ranking-position', '13'
      assert_select '.ranking .points-total', '20'
      assert_select '.ranking .points-match-average', '2.34'

      get user_path(other_user)
      assert_response :success
      assert_select 'h2', { text: stats_h2_text, count: 1 }
    end

    travel_to before_the_world_cup do
      # reset match scores to simulate no matches are finished
      assert Match.update_all(left_team_score: nil, right_team_score: nil).positive?

      get authenticated_root_path
      assert_response :success
      assert_select 'h2', { text: your_stats_h2_text, count: 0 },
        'Stats should not be desplayed for own user before the world cup'

      get user_path(other_user)
      assert_response :success
      assert_select 'h2', { text: stats_h2_text, count: 0 },
        'Stats should not be desplayed for other user before the world cup'
    end
  end

  test 'user sees how many predictions are missing' do
    user = users(:diego)

    sign_in user
    get authenticated_root_path

    assert_select '.unpredicted_matches' do
      assert_select 'h2', 'Hurry!'
      assert_select '.ci-number-of-unpredicted-matches', 'You have 3 unpredicted matches'
      assert_select 'a.btn.btn-primary', 'Predict them now!'
    end
  end

  test 'koebi sees his ranking in squad overview' do
    koebi = users(:koebi)

    sign_in koebi
    get authenticated_root_path
    assert_response :success

    assert_select '.squad_members .squad_member' do
      assert_select '.ci-squad-name', 'CH Stars'
      assert_select '.ci-squad-ranking', 'You are ranked # 3 out of 3 players'
    end
  end

  test 'user sees only stats and squads on other users page' do
    user = users(:zinedine)
    other_user = users(:diego)

    sign_in user
    get user_path(other_user)
    assert_response :success

    assert_select 'h1', 'Diego Maradona'
    assert_select 'h2', 'Stats'
    assert_select 'h2', 'Squads'
    assert_select 'h2', count: 2
  end

  test 'user changes the nickname' do
    user = users(:zinedine)

    sign_in user
    get authenticated_root_path
    assert_response :success

    assert_select 'h1', 'Your locker'
    assert_select 'a[href="/users/zinedine-zidane-22222/nickname/edit"]', 'Change'

    get edit_user_nickname_path(user)
    assert_response :success

    assert_select 'h1', 'Name yourself'
    assert_select 'form input#user_nickname', count: 1
    submit_button = css_select('form input[type="submit"]').first
    assert_equal 'Change Nickname', submit_button.attributes['value'].text

    assert_changes 'user.nickname', from: 'Zidi', to: 'Zinedine' do
      patch user_nickname_path(user), params: {
        user: {
          nickname: 'Zinedine'
        }
      }
      follow_redirect!
      assert_response :success
      user.reload
    end
  end
end
