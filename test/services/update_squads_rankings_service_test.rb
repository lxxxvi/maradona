require 'test_helper'

class UpdateSquadsRankingsServiceTest < ActiveSupport::TestCase
  test 'updates rankings' do
    les_bleues, fifa_100, chicago_bulls, ch_stars = squads(:les_bleues, :fifa_100, :chicago_bulls, :ch_stars)

    # before
    assert_equal 2, squads(:les_bleues).ranking_position

    service = UpdateSquadsRankingsService.new
    service.run!

    les_bleues.reload
    fifa_100.reload
    chicago_bulls.reload
    ch_stars.reload

    assert_equal 1, les_bleues.ranking_position
    assert_equal 2, fifa_100.ranking_position
    assert_equal 2, chicago_bulls.ranking_position
    assert_equal 4, ch_stars.ranking_position
  end
end
