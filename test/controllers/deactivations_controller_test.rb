require 'test_helper'

class DeactivationsControllerTest < ActionDispatch::IntegrationTest
  test 'deactivates account' do
    user = users(:jordan)

    assert_changes 'user.deactivation_token' do
      assert_difference 'User.inactive.count' do
        assert_difference 'SquadMember.inactive.count' do
          get deactivate_url(user.deactivation_token)
          assert_response :success
          user.reload
        end
      end
    end
  end

  test 'throws error for invalid deactivation token' do
    assert_raises(ActiveRecord::RecordNotFound) {
      get deactivate_url('invalid_token')
    }
  end

  test 'chappi deactivates, squads stats of ch_stars changes' do
    user = users(:chappi)
    squad = squads(:ch_stars)

    assert_changes 'squad.points_average' do
      assert_changes 'squad.accepted_players_total' do
        get deactivate_url(user.deactivation_token)
        assert_response :success
        squad.reload
      end
    end
  end

  test 'chappi deactivates, squad member ranking points changes' do
    user = users(:chappi)
    chappi_in_ch_stars = squad_members(:chappi_in_ch_stars)
    koebi_in_ch_stars = squad_members(:koebi_in_ch_stars)

    assert_equal 1, chappi_in_ch_stars.ranking_position, 'Chappi should be 1st before'
    assert_equal 3, koebi_in_ch_stars.ranking_position, 'Koebi should be 3rd before'

    get deactivate_url(user.deactivation_token)
    assert_response :success

    chappi_in_ch_stars.reload
    koebi_in_ch_stars.reload

    assert_nil chappi_in_ch_stars.ranking_position, 'Chappi should not longer have ranking'
    assert_equal 1, koebi_in_ch_stars.ranking_position, 'Koebi should be 1st after'
  end
end
