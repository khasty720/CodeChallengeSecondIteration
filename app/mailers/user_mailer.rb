class UserMailer < ApplicationMailer

  def emergency_contact_email(user)
    @user = user
    mail(to: @user.email, subject: 'Account Information')
  end
end
