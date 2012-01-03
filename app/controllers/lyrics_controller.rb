class LyricsController < ApplicationController
  def lyrics
    @lyric = Lyric.by_params(params)

    if @lyric.fetch_and_save
      render :text => @lyric.text
    else
      render :text => "Sorry, we don't have any lyrics for this song"
    end
  end
end
