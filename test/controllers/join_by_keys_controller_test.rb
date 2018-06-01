require 'test_helper'

class JoinByKeysControllerTest < ActionDispatch::IntegrationTest
  include SquadHelper

  test 'signed in kubi joins ch_stars through invitation link' do
    user = users(:kubi)
    squad = squads(:ch_stars)

    assert_not accepted_user_in_squad?(user, squad), 'Kubi should NOT be in squad before'

    sign_in user

    get squad_invitation_link(squad)
    follow_redirect!
    assert :success

    assert accepted_user_in_squad?(user, squad), 'Kubi SHOULD be in squad after'
  end

  test 'cannot join through inviation link with wrong inviation key' do
    user = users(:kubi)
    squad = squads(:ch_stars)

    assert_not accepted_user_in_squad?(user, squad), 'Kubi should NOT be in squad before'
    squad.invitation_key = 'WRONGKEY'

    sign_in user

    get squad_invitation_link(squad)
    follow_redirect!
    assert :success

    assert_not accepted_user_in_squad?(user, squad), 'Kubi SHOULD still NOT be in squad after'
    assert_equal 'Not possible to join squad, did you use the right link?', flash[:notice]
  end

  private

  def accepted_user_in_squad?(user, squad)
    squad
      .squad_members
      .accepted
      .collect { |squad_member| squad_member.user }
      .include?(user)
  end
end
