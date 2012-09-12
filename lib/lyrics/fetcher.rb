require 'cgi'
require 'uri'
require 'nokogiri'
require 'open-uri'
require_relative './parser'

module Lyrics
  class Fetcher

    attr_reader :artist, :title

    def initialize(artist, title)
      @artist = titleize(artist)
      @title = titleize(title)
    end

    def artist
      CGI.escape(titleize(@artist))
    end

    def title
      CGI.escape(titleize(@title))
    end

    def result
      response = text_from_wikia
      if response == ""
        ParserResult.new(:empty, "Sorry, We don't have lyrics for this song yet.")
      else
        process(response)
      end

    end

    # we can't use Rails' #titleize since we need to deal with stuff like
    # "LCD Soundsystem"
    def titleize(string)
      strings = string.split
      strings.each do |str|
        str[0] = str[0].capitalize
      end
      title = strings.join(" ").gsub(" ", "_")
    end

    def lyrics_url
      "http://lyrics.wikia.com/index.php?title=#{artist}:#{title}&action=edit"
    end

    private

    def process(text)
      regex = /<lyrics?>(.*?)<\/lyrics?>/m
      if match = regex.match(text)
        Lyrics::Parser.new(match.captures.first).result
      else
        look_for_redirects(text)
      end
    end

    def text_from_wikia
      document = Nokogiri::HTML(open(lyrics_url))
      textarea = document.css("#wpTextbox1").first
      if textarea.nil?
        ""
      else
        textarea.text
      end
    end

    def look_for_redirects(text)
      regex = /REDIRECT \[\[([\w\s]+):(\w\s[:punct:])\]\]/m
      if match = regex.match(text)
        Fetcher.new(match.captures[0], match.captures[1]).result
      else
        ParserResult.new(:empty, "Sorry, We don't have lyrics for this song yet.")
      end
    end
  end
end
