require 'test_helper'

class Squads::MemberInvitationsControllerTest < ActionDispatch::IntegrationTest
  test 'cannot invite user a second time' do
    sign_in users(:diego)
    squad = squads(:fifa_100)

    assert_no_difference 'squad.squad_members.count' do
      post squad_member_invitations_path(squad), params: {
        squad_member_invitation: {
          nickname: 'zinedine.zidane'
        }
      }
      assert_response :success
    end
  end
end
