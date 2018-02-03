class PredictionEvaluationService
  OVERALL_OUTCOME_CORRECT_POINTS = 5
  TEAM_SCORE_CORRECT_POINTS = 2
  GOAL_DIFFERENCE_CORRECT_POINTS = 1
  NO_POINTS = 0

  attr_reader :predicted_scores, :actual_scores

  def initialize(actual_scores, predicted_scores)
    @actual_scores = actual_scores
    @predicted_scores = predicted_scores
  end

  def points_total
    points_left_team_score +
    points_right_team_score +
    points_overall_outcome +
    points_goal_difference
  end

  def points_overall_outcome
    return OVERALL_OUTCOME_CORRECT_POINTS if overall_outcome_correct?
    NO_POINTS
  end

  def points_left_team_score
    return TEAM_SCORE_CORRECT_POINTS if left_team_score_correct?
    NO_POINTS
  end

  def points_right_team_score
    return TEAM_SCORE_CORRECT_POINTS if right_team_score_correct?
    NO_POINTS
  end

  def points_goal_difference
    return GOAL_DIFFERENCE_CORRECT_POINTS if goal_difference_correct?
    NO_POINTS
  end

  private

  def overall_outcome_correct?
    overall_outcome_for(predicted_scores) == overall_outcome_for(actual_scores)
  end

  def left_team_score_correct?
    predicted_scores[:left_team_score] == actual_scores[:left_team_score]
  end

  def right_team_score_correct?
    predicted_scores[:right_team_score] == actual_scores[:right_team_score]
  end

  def goal_difference_correct?
    goal_difference_for(predicted_scores) == goal_difference_for(actual_scores)
  end

  def overall_outcome_for(scores)
    return :left_wins   if scores[:left_team_score]  > scores[:right_team_score]
    return :right_wins  if scores[:right_team_score] > scores[:left_team_score]
    :draw
  end

  def goal_difference_for(scores)
    scores[:left_team_score] - scores[:right_team_score]
  end
end
