class SongMailer < ActionMailer::Base
  default from: "federico@mheroin.com"

  def new_song(song)
    @song = song
    @user = song.user
    mail(to: "federico@mheroin.com", subject: "New Song on makeitpersonal")
  end
end
