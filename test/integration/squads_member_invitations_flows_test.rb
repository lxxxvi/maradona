require 'test_helper'

class SquadsMemberInvitationsFlowsTest < ActionDispatch::IntegrationTest
  test 'diego invites a new member to squad' do
    sign_in users(:diego)

    invitation = squad_members(:juergen_in_fifa_100_invited)
    invitation.reject_invitation!

    squad = squads(:fifa_100)
    get squad_path(squad)
    assert_response :success

    assert_select 'a.btn-primary', 'Search and invite friend'
    assert_equal 2, squad_member_elements.count, 'There should be 2 squad members before the invitation'

    get new_squad_member_invitation_path(squad)
    form_submit_button = css_select('form input[type=submit].btn-primary').first
    assert_select 'h1', "Invite friend to Fifa 100"
    assert_select 'a', 'Back to squad'
    assert_equal 'Invite friend', form_submit_button.attr('value')
    assert_select '#squad_member_search_input'
    assert_select 'form #squad_member_invitation_player_id'

    assert_select '.invited.squad-members-list .card-text', { count: 0 }

    post squad_member_invitations_path(squad), params: {
      squad_member_invitation: {
        player_id: 'pele-nascimento-33333'
      }
    }
    follow_redirect!
    assert_response :success

    assert_select '.squad-members .squad-member .ci-user-nickname', 'Pele'
    assert_equal 3, squad_member_elements.count, 'There should be 3 squad members after the invitation'
  end

  test 'pele accepts an invitation' do
    squad = squads(:les_bleues)
    sign_in users(:pele)
    get authenticated_root_path

    assert_select 'nav span.invitations-count', '1', 'Pele should see an invitation in the navigation'

    assert_invitation_is_shown

    squad_members_count_before = css_select('.squad_members .squad_member').count

    post squad_accept_invitations_path(squad)
    follow_redirect!
    assert_response :success

    assert_select 'h1', 'Your locker'
    squad_members_count_after = css_select('.squad_members .squad_member').count
    assert_equal squad_members_count_before + 1, squad_members_count_after, 'There should be one more (accepted) squads'
    assert_select '.squad_invitations .card', { count: 0 }, 'There should not be any invitions anymore'
  end

  test 'pele rejects an invitation' do
    squad = squads(:les_bleues)
    sign_in users(:pele)

    get authenticated_root_path
    assert_response :success

    assert_invitation_is_shown

    squads_card_count_before = css_select('.squads .card').count

    post squad_reject_invitations_path(squad)
    follow_redirect!
    assert_response :success

    squads_card_count_after = css_select('.squads .card').count
    assert_select '.squad_invitations .card', { count: 0 }, 'There should not be any invitions anymore'
    assert_equal squads_card_count_before, squads_card_count_after, 'The number of (accepted) squads should not have changed'
  end

  private

  def assert_invitation_is_shown
    h2_title = css_select('h2.squad_invitations_header').text.gsub(/\n/, ' ').strip
    assert_equal 'You have 1 invitation', h2_title
    assert_select '.squad_invitations .card'
    assert_select '.squad_invitations .squad-name', 'Les Bleues'
    accept_invitation_form_button = css_select('.squad_invitations .accept_invitation').first
    reject_invitation_form_button = css_select('.squad_invitations .reject_invitation').first
    assert_equal 'Join', accept_invitation_form_button.attr('value')
    assert_equal 'Reject', reject_invitation_form_button.attr('value')
  end

  def squad_member_elements
    css_select('.squad-members .squad-member')
  end
end
