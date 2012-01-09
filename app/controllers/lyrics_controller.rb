class LyricsController < ApplicationController
  def lyrics
    @lyric = Lyric.by_params(params[:lyric] || params)

    if @lyric.fetch_and_save
      render @lyric
    else
      render :text => @lyric.text
    end
  end
end
