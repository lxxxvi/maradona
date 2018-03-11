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
    assert_select 'Send invitation', form_submit_button.attr('value').value
    assert_select 'form input[type=text][name=nickname]'

    post squad_member_invitation_path(squad), params: {
      user: {
        nickname: 'pele'
      }
    }
    follow_redirect!
    assert_response :success

    assert false
  end

  test 'cannot invite user that has accepted already' do
    assert false
  end

  test 'cannot invite user that has rejected' do
    assert false
  end
end
