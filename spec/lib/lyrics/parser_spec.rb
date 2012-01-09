require 'fast_spec_helper'
require 'lyrics/parser'

include Lyrics

describe Parser do
  context "symbol replacement" do
    it "recognizes the gracenote takedown notice" do
      parser = Parser.new("{{gracenote_takedown}}")
      parser.lyrics.should == parser.send(:gracedown_notice)
    end

    it "removes <sup> content in the lyrics" do
      parser = Parser.new("Oh<sup>hai  ()</sup>noway<sup>wai</sup>")
      parser.lyrics.should == "Ohnoway"
    end

    it "replaces '' with real quotes" do
      parser = Parser.new(%q[''Oh hai''])
      parser.lyrics.should == %q["Oh hai"]
    end

    it "replaces &quot; with real quotes" do
      parser = Parser.new("&quot;")
      parser.lyrics.should == '"'
    end

    it "recognizes non-existent lyrics" do
      parser = Parser.new("PUT LYRICS HERE")
      parser.lyrics.should == parser.send(:no_lyrics_notice)
    end
  end
end
