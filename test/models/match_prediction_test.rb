require 'test_helper'

class MatchPredictionTest < ActiveSupport::TestCase
  test 'method match' do
    mp = MatchPrediction.new({match_id: 222, match_left_team_id: 7})

    assert_equal 222, mp.match.id
    assert_equal 7, mp.match.left_team_id
    assert_equal Match, mp.match.class

    assert_nil mp.match.right_team_id
  end

  test 'method left team' do
    mp = MatchPrediction.new({left_team_id: 8})

    assert_equal 8, mp.left_team.id
    assert_equal Team, mp.left_team.class
  end

  test 'method right team' do
    mp = MatchPrediction.new({right_team_id: 9})

    assert_equal 9, mp.right_team.id
    assert_equal Team, mp.right_team.class
  end


  test 'method prediction' do
    mp = MatchPrediction.new({prediction_id: 4, prediction_right_team_score: 6})

    assert_equal 4, mp.prediction.id
    assert_equal 6, mp.prediction.right_team_score
    assert_equal Prediction, mp.prediction.class

    assert_nil  mp.prediction.left_team_score
  end
end
