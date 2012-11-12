class LovesController < ApplicationController
  before_filter :authenticate_user!

  def loved
    @songs = current_user.loved_songs
  end

  def loves
    @songs = current_user.loves_received
  end

  def create
    song = Song.find(params[:id])
    current_user.love(song)
    NotificationsMailer.loved(current_user, song).deliver
#    redirect_to :back
    render :nothing => true
  end

  def destroy
    love = current_user.loves.find_by_song_id(params[:id])
    love.destroy
#    redirect_to :back
    render :nothing => true
  end
end
