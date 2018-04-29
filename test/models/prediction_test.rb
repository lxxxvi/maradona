require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  setup do
    @prediction = predictions(:prediction_diego_egy_uru)
  end

  test 'score' do
    assert_equal expected_score, @prediction.score
  end

  def expected_score
    {
      left_team_score: 0,
      right_team_score: 1
    }
  end
end
