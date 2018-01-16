require 'test_helper'

class PredictionEvaluationServiceTest < ActiveSupport::TestCase

  attr_reader :match_rus_ksa, :user

  setup do
    @user = users(:diego)
    @match_rus_ksa = matches(:match_rus_ksa) # rus: 4, ksa: 1
  end

  test 'overall outcome predicted correctly' do
    prediction = prediction_for(user, 1, 0)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
  end

  test 'left team score predicted correctly' do
    prediction = prediction_for(user, 4, 5)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 2, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
  end

  test 'right team score predicted correctly' do
    prediction = prediction_for(user, 0, 1)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 2, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
  end

  test 'goal difference predicted correctly' do
    prediction = prediction_for(user, 3, 0)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
  end

  test 'everything predicted correctly' do
    prediction = prediction_for(user, 4, 1)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 5, service.points_overall_outcome
    assert_equal 2, service.points_left_team_score
    assert_equal 2, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
  end

  test 'nothing predicted correctly' do
    prediction = prediction_for(user, 0, 2)
    service = PredictionEvaluationService.new(prediction)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
  end

  test 'draw predicted correctly, wrong scores' do
    assert false # todo
  end

  private

  def prediction_for(user, left_team_score, right_team_score)
    user.predictions.new(
      match: match_rus_ksa,
      left_team_score: left_team_score,
      right_team_score: right_team_score
    )
  end
end
