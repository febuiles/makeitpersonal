require 'digest/md5'

module Lyrics
  class KeyCreator
    def self.key_for(params)
      artist = params.fetch(:artist) { "" }
      title = params.fetch(:title) { "" }
      return if artist.empty? or title.empty?

      artist = artist.downcase.gsub(/ /, "")
      title = title.downcase.gsub(/ /, "")

      Digest::MD5.hexdigest(artist + title)
    end
  end
end
