class Lyric < ActiveRecord::Base
  validates_presence_of :artist, :title, :text

  before_save :clean_attrs

  def self.by_params(params)
    find_by_artist_and_title(params[:artist].to_key, params[:title].to_key)
  end

  def self.from_params(params)
    artist, title = params[:artist], params[:title]

    lyrics = Lyric.by_params(params)
    return lyrics unless lyrics.blank?

    text = Lyrics::Fetcher.new(artist, title).lyrics
    lyric = Lyric.new(:artist => artist, :title => title, :text => text)
    lyric if lyric.save
  end

  def clean_attrs
    self.artist = artist.to_key
    self.title = title.to_key
  end
end
