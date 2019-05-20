require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test '/grapql games' do
    post '/graphql', params: { query: '{ games { id } }' }
    assert_operator parsed_response['data']['games'].count, :>, 1
  end

  test '/graphql updatePrediction' do
    game = games(:game_1)

    # post '/graphql', params: { query: mutation_query, variables: mutation_variables(game, 7, 6) }
    post '/graphql', params: { query: mutation_query2(game) }

    raise 'TODO: make me nice!'
    assert false
  end

  private

  def parsed_response
    JSON.parse(response.body)
  end

  def mutation_query2(game)
    <<~GQL
      mutation {
        updatePrediction(
          gameId: #{game.id},
          leftTeamScore: 7,
          rightTeamScore: 6
        ) {
          prediction {
            game {
              id
            }
            leftTeamScore
            rightTeamScore
          }
        }
      }
    GQL
  end

  # def mutation_query
  #   <<~GQL
  #     mutation updatePredictionMutation($gameId: ID!, $leftTeamScore: Int!, $rightTeamScore: Int!) {
  #       updatePrediction(
  #         gameId: $gameId,
  #         leftTeamScore: $leftTeamScore,
  #         rightTeamScore: $rightTeamScore
  #       ) {
  #         prediction {
  #           game {
  #             id
  #           }
  #           leftTeamScore
  #           rightTeamScore
  #         }
  #       }
  #     }
  #   GQL
  # end

  # def mutation_variables(game, left_team_score, right_team_score)
  #   <<~GQL
  #     {
  #       "gameId": #{game.id},
  #       "leftTeamScore": #{left_team_score},
  #       "rightTeamScore": #{right_team_score}
  #     }
  #   GQL
  # end
end
