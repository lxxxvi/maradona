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

  test 'cannot see invitation form for foreign squad' do
    sign_in users(:zinedine)
    squad = squads(:fifa_100) # coached by diego

    assert_raises(Pundit::NotAuthorizedError) {
      get new_squad_member_invitation_path(squad)
    }
  end

  test 'cannot invite user for a foreign squad' do
    sign_in users(:zinedine)
    squad = squads(:fifa_100) # coached by diego

    assert_no_difference 'squad.squad_members.count' do
      assert_raises(Pundit::NotAuthorizedError) {
        post squad_member_invitations_path(squad), params: {
          squad_member_invitation: {
            nickname: 'juergen.klinsmann'
          }
        }
      }
    end
  end
end
