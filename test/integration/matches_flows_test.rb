require 'test_helper'

class MatchesFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    get root_path
    assert_response :success
    assert_select '.match-with-prediction', { count: 3 }
  end

  test 'match cannot be predicted anymore because kickoff is in past' do
    match = matches(:match_rus_ksa)
    travel_to match.kickoff_at do
      get root_path
      assert_response :success

      first_game = css_select('.match-with-prediction').first
      assert_not first_game.css('.score-controls').present?
    end
  end
end
