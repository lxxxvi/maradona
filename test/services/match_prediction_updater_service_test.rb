require 'test_helper'

class MatchPredictionUpdaterServiceTest < ActiveSupport::TestCase
  test 'updates match without existing prediction' do
    match = matches(:match_rus_ksa)
    user = users(:diego)

    left_team_score = 5
    left_team_score = 9

    service = MatchPredictionUpdaterServiceTest.new(match, user)
    result = service.update(left_team_score, right_team_score)
    assert_equal [5, 9], result
  end
end
