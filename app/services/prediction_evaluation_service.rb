class PredictionEvaluationService
  OVERALL_OUTCOME_CORRECT_POINTS = 5
  TEAM_SCORE_CORRECT_POINTS = 2
  GOAL_DIFFERENCE_CORRECT_POINTS = 1
  NO_POINTS = 0

  attr_reader :prediction, :match

  def initialize(prediction)
    @prediction = prediction
    @match = @prediction.match
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
    overall_outcome_for(prediction) == overall_outcome_for(match)
  end

  def left_team_score_correct?
    prediction.left_team_score == match.left_team_score
  end

  def right_team_score_correct?
    prediction.right_team_score == match.right_team_score
  end

  def goal_difference_correct?
    goal_difference_for(prediction) == goal_difference_for(match)
  end

  def overall_outcome_for(match_or_prediction)
    left_team_score   = match_or_prediction.left_team_score
    right_team_score  = match_or_prediction.right_team_score
    return :left_wins   if left_team_score  > right_team_score
    return :right_wins  if right_team_score > left_team_score
    :draw
  end

  def goal_difference_for(match_or_prediction)
    match_or_prediction.left_team_score - match_or_prediction.right_team_score
  end
end
