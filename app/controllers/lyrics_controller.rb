class LyricsController < ApplicationController
  skip_before_filter :track_visit
  before_filter :validate_params

  def lyrics
    @lyric = Lyric.by_params(params[:lyric] || params)
    mixpanel.track 'API Request', { artist: @lyric.artist, title: @lyric.title }
    if @lyric.fetch_and_save
      render @lyric
    else
      render :text => @lyric.text
    end
  end

  protected

  def validate_params
    [:artist, :title].each do |field|
      return empty_field(field) if params[field].blank?
    end
  end

  def empty_field(field)
    render :text => "#{field} is empty", :status => 422
  end
end
