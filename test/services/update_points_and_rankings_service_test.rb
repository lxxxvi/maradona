require 'test_helper'

class UpdatePointsAndRankingsServiceTest < ActiveSupport::TestCase
  test 'updates points and rankings' do
    top_user = users(:zinedine)
    top_squad = squads(:les_bleues)

    assert_not_equal 1, top_user.ranking_position
    assert_not_equal 1, top_squad.ranking_position

    service = UpdatePointsAndRankingsService.new
    service.run!

    top_user.reload
    top_squad.reload

    assert_equal 1, top_user.ranking_position
    assert_equal 1, top_squad.ranking_position
  end
end
