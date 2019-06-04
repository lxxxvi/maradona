require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'unique attributes' do
    user = users(:laura)

    new_user = User.new(
      username: user.username,
      slug: user.slug,
      email: user.email
    )
    new_user.validate

    assert_equal ['has already been taken'], new_user.errors[:username]
    assert_equal ['has already been taken'], new_user.errors[:slug]
    assert_equal ['has already been taken'], new_user.errors[:email]
  end
end
