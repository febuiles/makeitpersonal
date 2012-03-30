require 'fast_spec_helper'
require 'lyrics/parser'

include Lyrics

describe Parser do
  context "symbol replacement" do
    it "recognizes the gracenote takedown notice" do
      parser = Parser.new("{{gracenote_takedown}}")
      parser.result.status.should == :taken_down
    end

    it "removes <sup> content in the lyrics" do
      parser = Parser.new("Oh<sup>hai  ()</sup>noway<sup>wai</sup>")
      parser.result.lyrics.should == "Ohnoway"
    end

    it "replaces '' with real quotes" do
      parser = Parser.new(%q[''Oh hai''])
      parser.result.lyrics.should == %q["Oh hai"]
    end

    it "replaces &quot; with real quotes" do
      parser = Parser.new("&quot;")
      parser.result.lyrics.should == '"'
    end

    it "recognizes non-existent lyrics" do
      parser = Parser.new("PUT LYRICS HERE")
      parser.result.status.should == :empty
    end
  end
end
