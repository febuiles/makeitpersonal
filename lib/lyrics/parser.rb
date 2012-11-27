require 'parser_result'

module Lyrics
  class Parser
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def result
      status = ""
      lyrics = ""

      operations.each do |regex, replacement|
        next unless regex.match(text)

        status, lyrics = send(replacement)

        if status != :ok
          return ParserResult.new(status, lyrics)
        else
          text.gsub!(regex, lyrics)
        end
      end

      ParserResult.new(:ok, text)
    end

    private

    def operations
      {
        /{{Instrumental}}/ => :instrumental,
        /{{gracenote_takedown}}/ => :gracedown_notice,
        /PUT LYRICS HERE/ => :no_lyrics_notice,
        /<sup>.*?<\/sup>/ => :sup_tags,
        /''/ => :quote,
        /&quot;/ => :quote
      }
    end

    def instrumental
      [:ok, "Instrumental"]
    end

    def gracedown_notice
      [:taken_down, "Sorry, Gracedown has taken down this song."]
    end

    def no_lyrics_notice
      [:empty, "Sorry, We don't have lyrics for this song yet."]
    end

    def sup_tags
      [:ok, ""]
    end

    def quote
      [:ok, '"']
    end
  end


end
