require 'test_helper'

class MatchesFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    sign_in users(:diego)

    get prediction_center_path
    assert_response :success
    assert_select '.match-with-prediction', { count: 5 }
    assert_select '#prediction-center-actions .upcoming-matches.pushed', 'Upcoming'
    assert_select '#prediction-center-actions .finished-matches', 'Finished'
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

  test 'kickoff time is shown for upcoming match' do
    sign_in users(:diego)
    match = matches(:match_egy_uru)

    travel_to (match.kickoff_at - 30.minutes) do
      get prediction_center_path
      assert_response :success
      first_game = css_select('.match-with-prediction.future').first
      first_game_kickoff_time = first_game.css('.ci-kickoff-time').first
      assert_equal "Kickoff in\n\n30 minutes", first_game_kickoff_time.text.strip
    end
  end
end
