require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test '#ordered_by_kickoff' do
    Game.ordered_by_kickoff.tap do |games|
      assert_equal games(:game_1), games.first
      assert_equal games(:game_2), games.second
    end
  end

  test '#score_present?' do
    game = games(:game_1)

    assert game.valid?, 'Should be valid before'

    game.left_team_score = 'INVALID'
    game.right_team_score = 'INVALID'
    game.validate
    assert_equal %i[left_team_score right_team_score], game.errors.keys.sort

    game.left_team_score = 1
    game.validate
    assert_equal %i[right_team_score], game.errors.keys.sort

    game.right_team_score = 0
    assert game.valid?, 'Should be valid after'
  end

  test 'predictions'
end
