class UserMailer < ActionMailer::Base
  def welcome(user, generated_password)
    @user = user
    @password = generated_password
    mail(to: @user.email, subject: 'Welcome')
  end
end