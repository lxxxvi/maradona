require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test '/grapql games' do
    post '/graphql', params: { query: '{ games { id } }' }
    assert parsed_response['data']['games'].any?
  end

  test '/graphql updatePrediction' do
    game = games(:game_1)

    assert_changes 'game.predictions.first.left_team_score', to: 7 do
      post '/graphql', params: { query: mutation_query(game) }
    end

    prediction = parsed_response['data']['updatePrediction']['prediction']

    assert_equal game.id.to_s, prediction['game']['id']
    assert_equal 7, prediction['leftTeamScore']
    assert_equal 6, prediction['rightTeamScore']
  end

  private

  def parsed_response
    JSON.parse(response.body)
  end

  def mutation_query(game)
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
end
