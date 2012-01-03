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
      lyrics = process(text_from_wikia)
      if lyrics.include?("PUT LYRICS HERE") # song doesn't exist on Wikia yet
        ""
      else
        lyrics
      end
    end

    private

    def process(text)
      regex = /<lyrics>(.*)<\/lyrics>/m
      if match = regex.match(text)
        match.captures.first
      else
        look_for_redirects(text)
      end
    end

    def text_from_wikia
      url = "http://lyrics.wikia.com/index.php?title=#{artist}:#{title}&action=edit"
      document = Nokogiri::HTML(open(url))
      textarea = document.css("#wpTextbox1").first.text
    end

    def look_for_redirects(text)
      regex = /REDIRECT \[\[([\w\s]+):([\w\s]+)/m
      if match = regex.match(text)
        Fetcher.new(match.captures[0], match.captures[1]).lyrics
      else
        ""
      end
    end
  end
end
