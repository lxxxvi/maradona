require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  setup do
    @prediction = predictions(:prediction_diego_egy_uru)
  end

  test 'score' do
    assert_equal expected_score, @prediction.score
  end

  test 'collect and persist points' do
    match = @prediction.match
    match.left_team_score = 1
    match.right_team_score = 2

    assert_changes '@prediction.points_total', to: 6 do
      @prediction.collect_points!
    end
  end

  def expected_score
    {
      left_team_score: 0,
      right_team_score: 1
    }
  end
end
