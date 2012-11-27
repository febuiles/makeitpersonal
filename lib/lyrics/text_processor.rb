# -*- coding: utf-8 -*-
require_relative './parser'

module Lyrics
  class TextProcessor
    LYRIC_REGEX = /lyrics?>(.*?)(<|&lt;)\/lyrics?>/m
    REDIRECT_REGEX = /REDIRECT \[\[(.*?):(.*?)\]\]/m

    def initialize(text)
      @text = text
    end

    def clean_result
      if match = LYRIC_REGEX.match(@text)
        Lyrics::Parser.new(match.captures.first).result
      else
        look_for_redirects
      end
    end

    private

    def look_for_redirects
      if match = REDIRECT_REGEX.match(@text)
        fetcher = TextFetcher.new(match.captures[0], match.captures[1])
        @text = fetcher.text
        clean_result
      else
        ParserResult.new(:empty, "Sorry, We don't have lyrics for this song yet.")
      end
    end
  end
end
