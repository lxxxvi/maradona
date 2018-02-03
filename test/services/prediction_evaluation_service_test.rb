require 'test_helper'

class PredictionEvaluationServiceTest < ActiveSupport::TestCase
  attr_reader :winning_score

  setup do
    @winning_score = create_score(4, 1)
  end

  test 'overall outcome predicted correctly' do
    predicted_score = create_score(1, 0)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 5, service.points_total
  end

  test 'left team score predicted correctly' do
    predicted_score = create_score(4, 5)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal 0, service.points_overall_outcome
    assert_equal 2, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 2, service.points_total
  end

  test 'right team score predicted correctly' do
    predicted_score = create_score(0, 1)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 2, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 2, service.points_total
  end

  test 'goal difference predicted correctly' do
    predicted_score = create_score(3, 0)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
    assert_equal 6, service.points_total
  end

  test 'everything predicted correctly' do
    predicted_score = create_score(4, 1)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal  5, service.points_overall_outcome
    assert_equal  2, service.points_left_team_score
    assert_equal  2, service.points_right_team_score
    assert_equal  1, service.points_goal_difference
    assert_equal 10, service.points_total
  end

  test 'nothing predicted correctly' do
    predicted_score = create_score(0, 2)
    service = PredictionEvaluationService.new(winning_score, predicted_score)

    assert_equal 0, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 0, service.points_goal_difference
    assert_equal 0, service.points_total
  end

  test 'draw predicted correctly, wrong scores' do
    predicted_score = create_score(1, 1)
    draw_score = create_score(2, 2)
    service = PredictionEvaluationService.new(draw_score, predicted_score)

    assert_equal 5, service.points_overall_outcome
    assert_equal 0, service.points_left_team_score
    assert_equal 0, service.points_right_team_score
    assert_equal 1, service.points_goal_difference
    assert_equal 6, service.points_total
  end

  private

  def create_score(left_team_score, right_team_score)
    {
      left_team_score: left_team_score,
      right_team_score: right_team_score
    }
  end
end
