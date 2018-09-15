class LyricsController < ApplicationController
  before_filter :set_params
  before_filter :validate_params

  def lyrics
    @lyric = Lyric.by_params(params[:lyric] || params)
    if @lyric.fetch_and_save
      render @lyric
    else
      render :text => @lyric.text
    end
  end

  protected

  def validate_params
    if @artist.blank? ||
        @title.blank? ||
        @artist.length > 72 ||
        @title.length > 72
      return render(:text => "Invalid params", :status => 422)
    end
  end

  def set_params
    @artist = params[:artist]
    @title = params[:title]
  end
end
