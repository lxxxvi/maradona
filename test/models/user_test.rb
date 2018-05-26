require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'gets random player_id and deactivation_token' do
    user = User.new(email: 'foo@bar.dev', password: 'abcdef', password_confirmation: 'abcdef')
    user.save!

    assert_match /[a-z]+/, user.player_id
    assert_equal user.player_id, user.nickname, 'nickname should be same as player_id'
    assert_match /[[:alnum:]]{64}/, user.deactivation_token
  end
end
