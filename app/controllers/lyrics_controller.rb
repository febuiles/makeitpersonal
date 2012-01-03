class LyricsController < ApplicationController
  def lyrics
    render :text => Lyric.from_params(params).text
  rescue NoMethodError
    render :text => "Sorry, we don't have any lyrics for this song"
  end
end
