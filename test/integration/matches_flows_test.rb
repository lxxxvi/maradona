require 'test_helper'

class MatchesFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    sign_in users(:diego)

    get prediction_center_path
    assert_response :success
    assert_select '.match-with-prediction', { count: 5 }
  end

  test 'match cannot be predicted anymore because kickoff is in past' do
    sign_in users(:diego)

    match = matches(:match_rus_ksa)
    travel_to match.kickoff_at do
      get prediction_center_path
      assert_response :success

      first_game = css_select('.match-with-prediction').first
      assert_not first_game.css('.score-controls').present?
    end
  end
end
