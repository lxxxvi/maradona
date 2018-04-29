require 'test_helper'

class UpdateSquadsPointsServiceTest < ActiveSupport::TestCase
  setup do
    @squad = squads(:ch_stars)
  end

  test 'updates squads points' do
    service = UpdateSquadsPointsService.new

    assert_equal 0, @squad.points_total
    assert_equal 0, @squad.points_average

    service.run!
    @squad.reload

    assert_equal 18, @squad.points_total
    assert_equal  6, @squad.points_average
  end
end
