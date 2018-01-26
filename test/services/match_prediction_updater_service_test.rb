require 'test_helper'

class MatchPredictionUpdaterServiceTest < ActiveSupport::TestCase
  attr_reader :match_rus_ksa, :user

  setup do
    @match_rus_ksa = matches(:match_rus_ksa)
    @user  = users(:diego)
  end

  test 'updates match without existing prediction' do
    travel_to before_the_world_cup do
      service = MatchPredictionUpdaterService.new(match_rus_ksa, user)
      response = service.update(5, 9)

      assert_equal :ok, response.status
      assert_equal ['Updated successfully'], response.messages
      assert_equal 5, response.payload[:left_team_score]
      assert_equal 9, response.payload[:right_team_score]
    end
  end

  test 'does not update match with wrong left team score values' do
    travel_to before_the_world_cup do
      service = MatchPredictionUpdaterService.new(match_rus_ksa, user)
      response = service.update(-1, 0)

      assert_equal :error, response.status
      assert_equal ['Left team score must be greater than or equal to 0'], response.messages
    end
  end

  test 'does not update match with wrong right team score values' do
    travel_to before_the_world_cup do
      service = MatchPredictionUpdaterService.new(match_rus_ksa, user)
      response = service.update(0, -1)

      assert_equal :error, response.status
      assert_equal ['Right team score must be greater than or equal to 0'], response.messages
    end
  end

  test 'does not update scores after kickoff' do
    travel_to match_rus_ksa.kickoff_at do
      service = MatchPredictionUpdaterService.new(match_rus_ksa, user)
      response = service.update(0, 0)

      assert_equal :error, response.status
      assert_equal ["Oh no, you're too late to predict that game"], response.messages
    end
  end
end
