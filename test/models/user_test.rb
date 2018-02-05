require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'collect_points' do
    zinedine = users(:zinedine)

    assert_changes 'zinedine.points_total', to: 8 do
      zinedine.collect_points!
    end
  end
end
