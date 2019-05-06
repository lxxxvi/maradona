require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test '/grapql games' do
    post '/graphql', params: { query: '{ games { id } }' }
    assert_operator parsed_response['data']['games'].count, :>, 1
  end

  private

  def parsed_response
    JSON.parse(response.body)
  end
end
