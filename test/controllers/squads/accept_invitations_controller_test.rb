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
end
