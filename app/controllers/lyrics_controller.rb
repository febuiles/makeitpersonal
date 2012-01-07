class LyricsController < ApplicationController
  def lyrics
    @lyric = Lyric.by_params(params[:lyric] || params)

    if @lyric.fetch_and_save
      render @lyric
    else
      render :text => "Sorry, we don't have any lyrics for this song"
    end
  end
end
