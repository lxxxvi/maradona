require 'test_helper'

class DeactivationsControllerTest < ActionDispatch::IntegrationTest
  test 'deactivates account' do
    user = users(:jordan)

    assert_changes 'user.deactivation_token' do
      assert_difference 'User.inactive.count' do
        assert_difference 'SquadMember.inactive.count' do
          get deactivate_url(user.deactivation_token)
          assert_response :success
          user.reload
        end
      end
    end
  end

  test 'throws error for invalid deactivation token' do
    assert_raises(ActiveRecord::RecordNotFound) {
      get deactivate_url('invalid_token')
    }
  end
end
