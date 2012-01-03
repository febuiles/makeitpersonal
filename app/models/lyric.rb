class Lyric < ActiveRecord::Base

  def self.from_params(params)
    key = Lyrics::KeyCreator.key_for(params)

    lyrics = Lyric.find_by_key(key)

    if lyrics.blank?
      text = Lyrics::Fetcher.new(params[:artist], params[:title]).lyrics
      return if text.blank?
      lyrics = Lyric.create!(:key => key, :text => text)
    end
    lyrics
  end
end
