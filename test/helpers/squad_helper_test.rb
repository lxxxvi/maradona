require 'test_helper'

class SquadHelperTest < ActionView::TestCase
  test 'squad_invitation_link' do
    squad = squads(:ch_stars)

    assert_equal expected_ch_stars_invitation_link, squad_invitation_link(squad)
  end

  private

  def expected_ch_stars_invitation_link
    'http://test.host/squads/ch-stars/join_by_key/ch-stars-invitation-key'
  end
end
