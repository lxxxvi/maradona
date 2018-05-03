require 'test_helper'

class UpdateSquadMembersRankingsServiceTest < ActiveSupport::TestCase
  test 'updates rankings on all squad members' do
    service = UpdateSquadMembersRankingsService.new
    koebi_in_ch_stars = squad_members(:koebi_in_ch_stars)

    assert_equal 3, koebi_in_ch_stars.ranking_position
    service.run!

    koebi_in_ch_stars.reload
    assert_equal 1, koebi_in_ch_stars.ranking_position
  end

  test 'updates rankings on specific squad members' do
    squad = squads(:ch_stars)
    service = UpdateSquadMembersRankingsService.new(squad)
    koebi_in_ch_stars = squad_members(:koebi_in_ch_stars)

    assert_equal 3, koebi_in_ch_stars.ranking_position
    service.run!

    koebi_in_ch_stars.reload
    assert_equal 1, koebi_in_ch_stars.ranking_position
  end
end
