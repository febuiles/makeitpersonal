class Lyric < ActiveRecord::Base
  validates_presence_of :artist, :title, :text

  before_save :clean_attrs

  def self.by_params(params)
    find_by_artist_and_title(params[:artist].to_key,
                             params[:title].to_key) ||
      Lyric.new(:artist => params[:artist], :title => params[:title])
  end

  def fetch_and_save
    return true if text.present?
    result = Lyrics::Fetcher.new(artist, title).result
    return false if result.empty?

    self.text = result.lyrics
    if result.status == :ok
      self.save
    else
      return false
    end
  end

  private

  def clean_attrs
    self.artist = artist.to_key
    self.title = title.to_key
  end
end
