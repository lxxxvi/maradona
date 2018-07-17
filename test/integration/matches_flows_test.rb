require 'test_helper'

class MatchesFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    sign_in users(:diego)

    travel_to during_the_world_cup do
      get prediction_center_path
      assert_response :success
      assert_select '.match-with-prediction', { count: 5 }
      assert_select '#prediction-center-actions .upcoming-matches.pushed', 'Upcoming'
      assert_select '#prediction-center-actions .finished-matches', 'Finished'

      hidden_passed_matches_count = css_select('.match-with-prediction.passed.d-none').count
      assert hidden_passed_matches_count.positive?, 'Passed matches should be hidden if there are upcoming matches'
    end
  end

  test 'prediction center doesnt show buttons to toggle between matches' do
    sign_in users(:diego)

    Match.where(left_team_score: nil).update_all(left_team_score: 0)
    Match.where(right_team_score: nil).update_all(right_team_score: 0)

    travel_to after_the_world_cup do
      get prediction_center_path
      assert_response :success

      assert_select '.upcoming-matches', { count: 0 }
      first_finished_match = css_select('.match-with-prediction.passed').first
      assert_nil first_finished_match.classes.delete('d-none'), 'Finished matches should be displayed after world cup'
    end
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

  test 'kickoff time and venue is shown for upcoming match' do
    sign_in users(:diego)
    match = matches(:match_egy_uru)

    travel_to (match.kickoff_at - 30.minutes) do
      get prediction_center_path
      assert_response :success

      first_game = css_select('.match-with-prediction.future').first
      first_game_kickoff_time = first_game.css('.ci-kickoff-time').first
      first_game_stadium = first_game.css('.ci-stadium').first
      first_game_city = first_game.css('.ci-city').first

      assert_equal "Kickoff in\n\n30 minutes", first_game_kickoff_time.text.strip
      assert_equal 'Cosmos Arena', first_game_stadium.text.strip
      assert_equal 'Samara', first_game_city.text.strip
    end
  end

  test 'live match' do
    sign_in users(:diego)
    match = matches(:match_egy_uru)

    travel_to match.kickoff_at + 15.minutes do
      get prediction_center_path
      assert_response :success

      assert_select '.ci-live', count: 1
    end
  end
end
