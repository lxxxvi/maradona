require 'test_helper'

class UpdateSquadsPointsServiceTest < ActiveSupport::TestCase
  setup do
    @squad = squads(:ch_stars)
  end

  test 'updates squads stats' do
    service = UpdateSquadsPointsService.new

    # reset stats
    @squad.update(
      points_total: 0,
      points_average: 0,
      accepted_players_total: 1
    )

    service.run!
    @squad.reload

    assert_equal  18, @squad.points_total
    assert_equal 600, @squad.points_average
    assert_equal   3, @squad.accepted_players_total
  end
end
