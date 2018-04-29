require 'test_helper'

class UpdateUsersPointsServiceTest < ActiveSupport::TestCase
  test 'updates points total of user' do
    diego = users(:diego)
    service = UpdateUsersPointsService.new

    assert_equal 20, diego.points_total
    service.run!
    diego.reload
    assert_equal 7, diego.points_total
  end
end
