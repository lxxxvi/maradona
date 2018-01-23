require 'test_helper'

class MatchPredictionUpdaterServiceTest < ActiveSupport::TestCase
  attr_reader :match, :user, :service

  setup do
    @match = matches(:match_rus_ksa)
    @user  = users(:diego)
    @service = MatchPredictionUpdaterService.new(@match, @user)
  end

  test 'updates match without existing prediction' do
    response = response_for_scores(5, 9)
    assert_equal :ok, response.status
    assert_equal ['Updated successfully'], response.messages
  end

  test 'does not update match with wrong left team score values' do
    response = response_for_scores(-1, 0)
    assert_equal :error, response.status
    assert_equal ['Left team score must be greater than or equal to 0'], response.messages
  end

  test 'does not update match with wrong right team score values' do
    response = response_for_scores(0, -1)
    assert_equal :error, response.status
    assert_equal ['Right team score must be greater than or equal to 0'], response.messages
  end

  private

  def response_for_scores(left_team_score, right_team_score)
    service.update(left_team_score, right_team_score)
  end
end
