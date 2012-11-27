require 'cgi'
require 'uri'
require 'nokogiri'
require 'open-uri'
require_relative '../../config/initializers/ext'

module Lyrics
  class TextFetcher
    attr_reader :artist, :title

    def initialize(artist, title)
      @artist = CGI.escape(artist.titleize_with_caps.underscored)
      @title = CGI.escape(title.titleize_with_caps.underscored)
    end

    def text
      document = Nokogiri::HTML(open(lyrics_url))
      textarea = document.css("#wpTextbox1").first
      textarea ? textarea.text : nil
    end

    def lyrics_url
      "http://lyrics.wikia.com/index.php?title=#{@artist}:#{@title}&action=edit"
    end
  end
end
