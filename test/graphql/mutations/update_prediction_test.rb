require 'test_helper'

class Mutations::UpdatePredictionTest < ActiveSupport::TestCase
  test 'updates a prediction' do
    game = games(:game_1)

    assert_changes 'game.predictions.reload.first.left_team_score', from: 1, to: 8 do
      result = Mutations::UpdatePrediction.new(object: nil, context: {}).resolve(
        game_id: game.id,
        left_team_score: 8,
        right_team_score: 9
      )

      prediction = result[:prediction]

      assert_equal game, prediction.game
      assert_equal 8, prediction.left_team_score
      assert_equal 9, prediction.right_team_score
    end
  end
end
