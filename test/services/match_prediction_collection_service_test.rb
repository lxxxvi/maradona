require 'test_helper'

class MatchPredictionCollectionServiceTest < ActiveSupport::TestCase
  test 'fetches all matches for user' do
    service = MatchPredictionCollectionService.new(users(:diego))
    assert_equal 5, service.matches_with_predictions.count
  end

  test 'fetches upcoming matches' do
    match = matches(:match_bra_sui)

    travel_to match.kickoff_at - 1.minute do
      service = MatchPredictionCollectionService.new(users(:diego), :next_upcoming)
      assert_equal 1, service.matches_with_predictions.count
      next_upcoming_match = service.matches_with_predictions.first

      assert_equal 'BRA', next_upcoming_match.left_team.fifa_country_code
      assert_equal 'SUI', next_upcoming_match.right_team.fifa_country_code
    end
  end
end
