require 'test_helper'

class Squads::AcceptInvitationsControllerTest < ActionDispatch::IntegrationTest
  test 'pele accepts his own' do
    sign_in users(:pele)
    invited_squad_member = squad_members(:pele_in_les_bleues_invited)

    assert_changes 'invited_squad_member.invitation_accepted_at', from: nil do
      post squad_accept_invitations_path(invited_squad_member.squad)
      invited_squad_member.reload
    end
  end

  test 'pele cannot accept another invitation' do
    sign_in users(:pele)
    foreign_invited_squad_member = squad_members(:juergen_in_fifa_100_invited)

    assert_raises(Pundit::NotDefinedError) {
      post squad_accept_invitations_path(foreign_invited_squad_member.squad)
    }
  end

  test 'kubi accepts invitation, squads points changes' do
    sign_in users(:kubi)

    invited_squad_member = squad_members(:kubi_in_ch_stars_not_accepted)
    squad = squads(:ch_stars)

    post squad_accept_invitations_path(invited_squad_member.squad)
    follow_redirect!
    assert_response :success

    squad.reload

    assert_equal  28, squad.points_total
    assert_equal 700, squad.points_average
    assert_equal   4, squad.accepted_players_total
  end

  test 'kubi accepts invitation, squad members ranking changes' do
    sign_in users(:kubi)

    kubi_in_ch_stars = squad_members(:kubi_in_ch_stars_not_accepted)

    assert_nil kubi_in_ch_stars.ranking_position

    post squad_accept_invitations_path(kubi_in_ch_stars.squad)
    follow_redirect!
    assert_response :success

    kubi_in_ch_stars.reload

    assert_equal 1, kubi_in_ch_stars.ranking_position
  end
end
