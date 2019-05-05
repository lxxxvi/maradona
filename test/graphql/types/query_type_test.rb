require 'test_helper'

class QueryTypeTest < ActiveSupport::TestCase
  test 'games' do
    result = MaradonaSchema.execute(games_query).to_h
    games = result['data']['games']

    assert_operator games.count, :>, 1, 'Should have more than 2 games'

    first_game, second_game, _other = games

    assert_equal 'Group A', first_game['tournamentStage']
    assert_equal '2020-06-12T18:00:00Z', first_game['kickoffAt']
    assert_equal 'POR', first_game['leftTeam']
    assert_equal 'ITA', first_game['rightTeam']

    assert_equal 'Group B', second_game['tournamentStage']
    assert_equal '2020-06-13T12:00:00Z', second_game['kickoffAt']
    assert_equal 'SWE', second_game['leftTeam']
    assert_equal 'NED', second_game['rightTeam']
  end

  private

  def games_query
    <<~GRAPHQL
      {
        games {
          id
          tournamentStage
          kickoffAt
          leftTeam
          rightTeam
        }
      }
    GRAPHQL
  end
end
