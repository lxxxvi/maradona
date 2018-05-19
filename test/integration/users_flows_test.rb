require 'test_helper'

class UsersFlowsTest < ActionDispatch::IntegrationTest
  test 'user sees ranking on show page' do
    user = users(:diego)
    user.update(ranking_position: 13)
    sign_in user

    get root_path

    assert_select '.ranking .ranking-position', '13'
    assert_select '.ranking .points-total', '20'
    assert_select '.ranking .points-match-average', '2.34'
  end

  test 'user sees how many predictions are missing' do
    user = users(:diego)

    sign_in user
    get root_path

    assert_select '.unpredicted_matches' do
      assert_select 'h2', 'Hurry!'
      assert_select '.ci-number-of-unpredicted-matches', 'You have 3 unpredicted matches'
      assert_select 'a.btn.btn-primary', 'Predict them now!'
    end
  end

  test 'koebi sees his ranking in squad overview' do
    koebi = users(:koebi)

    sign_in koebi
    get root_path
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

    assert_select 'h1', 'diego-maradona-11111'
    assert_select 'h2', 'Stats'
    assert_select 'h2', 'Squads'
    assert_select 'h2', count: 2
  end
end
