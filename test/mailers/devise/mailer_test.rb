require 'test_helper'

class Devise::MailerTest < ActionMailer::TestCase
  test 'reset password instructions' do
    user = users(:diego)
    email = Devise::Mailer.reset_password_instructions(user, "faketoken", {})

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['referee@test.tippkick.club'], email.from
    assert_equal ['diego@dev.tippkick.club'], email.to
    assert_equal 'Reset password instructions', email.subject
    assert_equal read_fixture('reset_password_instructions').join, email.body.to_s
  end
end
