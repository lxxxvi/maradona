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
end
