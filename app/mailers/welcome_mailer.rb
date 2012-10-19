class WelcomeMailer < ActionMailer::Base
  default from: "federico@mheroin.com"

  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Hello from makeitpersonal")
  end
end
