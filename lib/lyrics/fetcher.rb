require 'nokogiri'
require 'open-uri'
require_relative './parser'

module Lyrics
  class Fetcher
    def initialize(artist, title)
      @artist = artist
      @title = title
    end

    def artist
      titleize(@artist)
    end

    def title
      titleize(@title)
    end

    def result
      process(text_from_wikia)
    end

    private

    # we can't use Rails' #titleize since we need to deal with stuff like
    # "LCD Soundsystem"
    def titleize(string)
      strings = string.split
      strings.each do |str|
        str[0] = str[0].capitalize
      end
      strings.join(" ").gsub(" ", "_")
    end

    def process(text)
      regex = /<lyrics>(.*?)<\/lyrics>/m
      if match = regex.match(text)
        Lyrics::Parser.new(match.captures.first).result
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
        Fetcher.new(match.captures[0], match.captures[1]).result
      else
        ""
      end
    end
  end
end
