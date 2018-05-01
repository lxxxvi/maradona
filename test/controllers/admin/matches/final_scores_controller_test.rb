require 'test_helper'

class Admin::Matches::FinalScoresControllerTest < ActionDispatch::IntegrationTest
  test 'admin sets score for match' do
    sign_in_admin
    match_rus_ksa = matches(:match_rus_ksa)
    rooney = users(:rooney)
    prediction = predictions(:prediction_rooney_rus_ksa)

    get new_admin_match_final_score_path(match_rus_ksa)
    assert_response :success

    assert_nil rooney.points_total
    assert_nil prediction.points_total

    post admin_match_final_scores_path(match_rus_ksa), params: {
      match: {
        left_team_score: 8,
        right_team_score: 9
      }
    }
    follow_redirect!
    assert_response :success

    match_rus_ksa.reload
    rooney.reload
    prediction.reload

    assert_equal  10, rooney.points_total
    assert_equal 250, rooney.points_match_average
    assert_equal  10, prediction.points_total

    assert_equal 8, match_rus_ksa.left_team_score
    assert_equal 9, match_rus_ksa.right_team_score
  end
end
