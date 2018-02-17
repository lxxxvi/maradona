require 'test_helper'

class NameTest < ActiveSupport::TestCase
  test 'returns a nickname consisting of first and lastname' do
    nickname = Name.random_nickname

    assert_match /[a-z]*\.[a-z]*/, nickname
    assert_no_match /#/, nickname
  end
end
