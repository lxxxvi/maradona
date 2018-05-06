require 'test_helper'

class Admin::Matches::FinalScoresControllerTest < ActionDispatch::IntegrationTest
  test 'admin sets score for match' do
    sign_in_admin
    match_rus_ksa = matches(:match_rus_ksa)
    rooney = users(:rooney)
    prediction = predictions(:prediction_rooney_rus_ksa)
    koebi_in_ch_stars = squad_members(:koebi_in_ch_stars)

    get new_admin_match_final_score_path(match_rus_ksa)
    assert_response :success

    assert_nil rooney.points_total
    assert_nil prediction.points_total
    assert_equal 3, koebi_in_ch_stars.ranking_position

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
    koebi_in_ch_stars.reload

    assert_equal  10, rooney.points_total
    assert_equal 250, rooney.points_match_average
    assert_equal  10, prediction.points_total

    assert_equal 8, match_rus_ksa.left_team_score
    assert_equal 9, match_rus_ksa.right_team_score

    assert_equal 1, koebi_in_ch_stars.ranking_position
  end
end
