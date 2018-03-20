require 'test_helper'

class NameTest < ActiveSupport::TestCase
  test 'returns a player_id consisting of first and lastname' do
    player_id = Name.random_player_id

    assert_match /[a-z]+\-[a-z]+\-[0-9]{5}/, player_id
    assert_no_match /#/, player_id
  end
end
