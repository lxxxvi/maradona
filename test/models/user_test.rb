require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'collect_points' do
    zinedine = users(:zinedine)
    prediction = predictions(:prediction_zinedine_por_esp)
    assert_not prediction.evaluated?

    assert_changes 'zinedine.points_total', to: 18 do
      zinedine.collect_points!
      assert prediction.reload.evaluated?
    end
  end
end
