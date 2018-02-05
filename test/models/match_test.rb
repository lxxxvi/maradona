require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test 'score for finished match' do
    assert_equal expected_score, matches(:match_rus_ksa).score
  end

  test 'score for unfinished match' do
    assert_nil matches(:match_egy_uru).score
  end

  def expected_score
    {
      left_team_score: 4,
      right_team_score: 1
    }
  end
end
