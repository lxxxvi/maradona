require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  test 'scores' do
    prediction = Prediction.new(game: games(:game_1))
    prediction.validate

    assert prediction.errors.key?(:left_team_score)
    assert prediction.errors.key?(:right_team_score)

    prediction.attributes = {
      left_team_score: 0,
      right_team_score: 0
    }

    assert prediction.valid?
  end

  test 'cannot update after kickoff' do
    prediction = predictions(:prediction_game_1)

    travel_to prediction.game.kickoff_at do
      assert_not prediction.update(left_team_score: prediction.left_team_score + 1)
      assert prediction.errors.key?(:base)
      assert_equal ["The games' kickoff must be in the future"], prediction.errors.full_messages
    end
  end

  test 'previous_score_changes' do
    prediction = predictions(:prediction_game_1)

    prediction.update!(left_team_score: 2, right_team_score: 1)

    score_change = prediction.previous_score_changes.first
    assert_equal 'leftTeamScore', score_change[:score]
    assert_equal 1, score_change[:from]
    assert_equal 2, score_change[:to]

    score_change = prediction.previous_score_changes.last
    assert_equal 'rightTeamScore', score_change[:score]
    assert_equal 0, score_change[:from]
    assert_equal 1, score_change[:to]
  end
end
