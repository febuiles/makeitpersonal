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
    @adjective = ["awesome", "neat", "nifty", "lovely", "nice"].sample
    subject = "#{@lover.username} loved one of your songs"
    mail(to: @loved.email, subject: subject)
  end

  def contact(name, email, message)
    @name = name
    @email = email
    @message = message
    subject = "Contact form"
    mail(to: "federico@mheroin.com", subject: subject)
  end

  def new_user(user)
    @user = user
    subject = "New user on makeitpersonal"
    mail(to: "federico@mheroin.com", subject: subject)
  end
end
