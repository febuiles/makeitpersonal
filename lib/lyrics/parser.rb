module Lyrics
  class Parser
    attr_reader :text

    def initialize(text)
      @text = text
    end

    def lyrics
      operations.each do |regex, replacement|
        text.gsub!(regex, replacement)
      end
      text
    end

    private

    def operations
      {
        /{{gracenote_takedown}}/ => gracedown_notice,
        /PUT LYRICS HERE/ => no_lyrics_notice,
        /<sup>.*?<\/sup>/ => sup_tags,
        /''/ => quote,
        /&quot;/ => quote
      }
    end

    def gracedown_notice
      "Gracedown has taken down the rest of this song, sorry :("
    end

    def no_lyrics_notice
      "We don't have lyrics for this song yet"
    end

    def sup_tags
      ""
    end

    def quote
      '"'
    end
  end
end
