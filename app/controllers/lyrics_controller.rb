class LyricsController < ApplicationController
  def lyrics
    artist = params[:artist]
    song = params[:title]
    render :text => Lyrics::Fetcher.new(artist, song).lyrics
  end
end
