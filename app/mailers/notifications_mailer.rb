class NotificationsMailer < ActionMailer::Base
  default from: "federico@mheroin.com"

  def followed(follower, followed)
    @follower = follower
    @followed = followed
    subject = "#{follower.username} is now following you on makeitpersonal"
    mail(to: followed.email, subject: subject)
  end
end
