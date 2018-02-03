require 'test_helper'

class PredictionEvaluationServiceTest < ActiveSupport::TestCase
  attr_reader :match_rus_ksa, :match_mar_irn, :user

  setup do
    @user = users(:diego)
    @match_rus_ksa = matches(:match_rus_ksa) # rus: 4, ksa: 1
    @match_mar_irn = matches(:match_mar_irn) # mar: 2, irn: 2
  end

  test 'overall outcome predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 1, 0)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 5, service.points_total
  end

  test 'left team score predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 4, 5)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 2, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 2, service.points_total
  end

  test 'right team score predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 0, 1)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 2, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 2, service.points_total
  end

  test 'goal difference predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 3, 0)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
    assert_equal 6, service.points_total
  end

  test 'everything predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 4, 1)
    service = PredictionEvaluationService.new(prediction)

    assert_equal  5, service.points_overall_outcome
    assert_equal  2, service.points_left_team_score
    assert_equal  2, service.points_right_team_score
    assert_equal  1, service.points_goal_difference
    assert_equal 10, service.points_total
  end

  test 'nothing predicted correctly' do
    prediction = prediction_for(user, match_rus_ksa, 0, 2)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 0, service.points_total
  end

  test 'draw predicted correctly, wrong scores' do
    prediction = prediction_for(user, match_mar_irn, 1, 1)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
    assert_equal 6, service.points_total
  end

  private

  def prediction_for(user, match, left_team_score, right_team_score)
    user.predictions.new(
      match: match,
      left_team_score: left_team_score,
      right_team_score: right_team_score
    )
  end
end
