require 'test_helper'

class DeactivationFlowsTest < ActionDispatch::IntegrationTest
  test 'user deactivates account' do
    get deactivate_url('jordan_deactivation_token')
    assert_response :success

    assert_select 'h1', 'Sorry for the trouble...'
  end
end
