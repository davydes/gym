class UserMailer < ActionMailer::Base
  default from: ENV['MAILER_FROM']

  def welcome(user_id, generated_password)
    @user = User.find(user_id)
    @password = generated_password
    mail(to: @user.email, subject: 'Welcome')
  end
end