require 'test_helper'

class SquadsMemberInvitationsFlowsTest < ActionDispatch::IntegrationTest
  test 'diego invites a new member to squad' do
    sign_in users(:diego)
    squad = squads(:fifa_100)
    get squad_path(squad)
    assert_response :success

    assert_select 'a.btn-primary', 'Invite friend to squad'

    get new_squad_member_invitation_path(squad)
    form_submit_button = css_select('form input[type=submit].btn-primary').first
    assert_select 'h1', "Invite friend to Fifa 100"
    assert_select 'a.btn-default', 'Cancel'
    assert_equal 'Invite friend', form_submit_button.attr('value')
    assert_select 'form #squad_member_invitation_nickname'

    post squad_member_invitations_path(squad), params: {
      squad_member_invitation: {
        nickname: 'pele'
      }
    }
    follow_redirect!
    assert_response :success

    assert_select '.squad_members .card-text', 'pele'
  end
end
