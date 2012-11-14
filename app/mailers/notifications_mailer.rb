class NotificationsMailer < ActionMailer::Base
  default from: "makeitpersonal <no-reply@makeitpersonal.co>"

  def followed(follower, followed)
    @follower = follower
    @followed = followed
    subject = "#{follower.username} is now following you on makeitpersonal"
    mail(to: followed.email, subject: subject)
  end

  def loved(user, song)
    @lover = user
    @loved = song.user
    @song = song
    subject = "#{@lover.username} loved one of your songs"
    mail(to: @loved.email, subject: subject)
  end
end
