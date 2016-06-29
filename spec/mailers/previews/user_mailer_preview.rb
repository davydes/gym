class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.welcome(User.first.id, 'qweasd123')
  end
end