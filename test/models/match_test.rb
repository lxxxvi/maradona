require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test 'upcoming scope' do
    travel_to before_the_world_cup do
      assert_equal 5, Match.upcoming.count
    end

    first_match = Match.ordered.first
    travel_to first_match.kickoff_at do
      assert_equal 4, Match.upcoming.count
    end
  end
end
