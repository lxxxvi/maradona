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

  test 'gets random player_id and deactivation_token' do
    user = User.new(email: 'foo@bar.dev', password: 'abcdef', password_confirmation: 'abcdef')
    user.save!

    assert_match /[a-z]+/, user.player_id
    assert_match /[[:alnum:]]{64}/, user.deactivation_token
  end
end
