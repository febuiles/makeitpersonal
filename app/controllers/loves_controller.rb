class LovesController < ApplicationController
  before_filter :authenticate_user!

  def loved
    @songs = current_user.loved_songs
  end

  def loves
    @songs = current_user.loves_received
  end

  def create
    @song = Song.find(params[:id])
    mixpanel.track 'Love', { from: current_user.username  }
    current_user.love(@song)
    NotificationsMailer.loved(current_user, @song).deliver
  end

  def destroy
    love = current_user.loves.find_by_song_id(params[:id])
    @song = love.song
    love.destroy
  end
end
