require 'nokogiri'
require 'open-uri'

module Lyrics
  class Fetcher
    def initialize(artist, title)
      @artist = artist
      @title = title
    end

    def artist
      @artist.titleize.gsub(" ", "_")
    end

    def title
      @title.titleize.gsub(" ", "_")
    end

    def lyrics
      url = "http://lyrics.wikia.com/index.php?title=#{artist}:#{title}&action=edit"
      document = Nokogiri::HTML(open(url))
      textarea = document.css("#wpTextbox1").first.text

      regex = /<lyrics>(.*)<\/lyrics>/m
      regex.match(textarea).captures.first
    end
  end
end
