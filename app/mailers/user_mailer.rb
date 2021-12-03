class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_new_password.subject
  #
  def send_new_password(user)
    @user_name= user.name

    mail to: @user_name, subject: "Resetting password"
  end
end
