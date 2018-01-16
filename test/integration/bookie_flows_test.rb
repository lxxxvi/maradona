require 'test_helper'

class BookieFlowsTest < ActionDispatch::IntegrationTest
  test 'landing page shows all games' do
    get root_path
    assert_response :success
    assert_select '.match-with-prediction', { count: 2 }
  end

  test 'first game shows all information' do
    get root_path
    assert_response :success
  end
end
