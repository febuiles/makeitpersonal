require 'text_fetcher'
require 'text_processor'
require_relative './parser'

module Lyrics
  class WikiaService
    attr_reader :artist, :title

    def self.lyrics_for(artist, title)
      response = TextFetcher.new(artist, title).text

      if response.present?
        TextProcessor.new(response).clean_result
      else
        Lyrics::ParserResult.new(:empty, "Sorry, We don't have lyrics for this song yet. Add them to https://lyrics.wikia.com")
      end
    end
  end
end
