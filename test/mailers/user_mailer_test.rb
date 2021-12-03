require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "send_new_password" do
    mail = UserMailer.send_new_password
    assert_equal "Send new password", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
