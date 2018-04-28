require 'test_helper'

class UpdatePredictionsPointsServiceTest < ActiveSupport::TestCase

  setup do
    @prediction = predictions(:prediction_diego_egy_uru)
    @match = matches(:match_egy_uru)

    @tied_prediction = predictions(:prediction_zinedine_por_esp)
    @tied_match = matches(:match_por_esp)
  end

  test 'all correct' do
    @match.update(left_team_score: 0, right_team_score: 1)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  2, @prediction.points_left_team_score
    assert_equal  2, @prediction.points_right_team_score
    assert_equal  5, @prediction.points_overall_outcome
    assert_equal  1, @prediction.points_goal_difference
    assert_equal 10, @prediction.points_total
  end

  test 'everything wrong' do
    @match.update(left_team_score: 1, right_team_score: 0)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  0, @prediction.points_left_team_score
    assert_equal  0, @prediction.points_right_team_score
    assert_equal  0, @prediction.points_overall_outcome
    assert_equal  0, @prediction.points_goal_difference
    assert_equal  0, @prediction.points_total
  end

  test 'left team score correct, rest wrong' do
    @match.update(left_team_score: 0, right_team_score: 0)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  2, @prediction.points_left_team_score
    assert_equal  0, @prediction.points_right_team_score
    assert_equal  0, @prediction.points_overall_outcome
    assert_equal  0, @prediction.points_goal_difference
    assert_equal  2, @prediction.points_total
  end

  test 'right team score correct, rest wrong' do
    @match.update(left_team_score: 2, right_team_score: 1)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  0, @prediction.points_left_team_score
    assert_equal  2, @prediction.points_right_team_score
    assert_equal  0, @prediction.points_overall_outcome
    assert_equal  0, @prediction.points_goal_difference
    assert_equal  2, @prediction.points_total
  end

  test 'overall outcome correct, nothing else' do
    @match.update(left_team_score: 10, right_team_score: 20)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  0, @prediction.points_left_team_score
    assert_equal  0, @prediction.points_right_team_score
    assert_equal  5, @prediction.points_overall_outcome
    assert_equal  0, @prediction.points_goal_difference
    assert_equal  5, @prediction.points_total
  end

  test 'overall outcome correct and goal difference' do
    @match.update(left_team_score: 10, right_team_score: 11)
    service = UpdatePredictionsPointsService.new(@match)
    service.run!
    @prediction.reload

    assert_equal  0, @prediction.points_left_team_score
    assert_equal  0, @prediction.points_right_team_score
    assert_equal  5, @prediction.points_overall_outcome
    assert_equal  1, @prediction.points_goal_difference
    assert_equal  6, @prediction.points_total
  end

  test 'overall outcome and goal difference correct in tied match' do
    @tied_prediction
    @tied_match.update(left_team_score: 4, right_team_score: 4)
    service = UpdatePredictionsPointsService.new(@tied_match)
    service.run!
    @tied_prediction.reload

    assert_equal  0, @tied_prediction.points_left_team_score
    assert_equal  0, @tied_prediction.points_right_team_score
    assert_equal  5, @tied_prediction.points_overall_outcome
    assert_equal  1, @tied_prediction.points_goal_difference
    assert_equal  6, @tied_prediction.points_total
  end

  test 'all correct in tied match' do
    @tied_prediction
    @tied_match.update(left_team_score: 3, right_team_score: 3)
    service = UpdatePredictionsPointsService.new(@tied_match)
    service.run!
    @tied_prediction.reload

    assert_equal  2, @tied_prediction.points_left_team_score
    assert_equal  2, @tied_prediction.points_right_team_score
    assert_equal  5, @tied_prediction.points_overall_outcome
    assert_equal  1, @tied_prediction.points_goal_difference
    assert_equal 10, @tied_prediction.points_total
  end
end
