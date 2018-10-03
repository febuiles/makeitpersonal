require 'fast_spec_helper'
require 'lyrics/parser'

include Lyrics

describe Parser do
  context "symbol replacement" do
    it "recognizes the gracenote takedown notice" do
      parser = Parser.new("{{gracenote_takedown}}")
      expect(parser.result.status).to eq(:taken_down)
    end

    it "removes <sup> content in the lyrics" do
      parser = Parser.new("Oh<sup>hai  ()</sup>noway<sup>wai</sup>")
      expect(parser.result.lyrics).to eq("Ohnoway")
    end

    it "replaces '' with real quotes" do
      parser = Parser.new(%q[''Oh hai''])
      expect(parser.result.lyrics).to eq(%q["Oh hai"])
    end

    it "replaces &quot; with real quotes" do
      parser = Parser.new("&quot;")
      expect(parser.result.lyrics).to eq('"')
    end

    it "recognizes non-existent lyrics" do
      parser = Parser.new("PUT LYRICS HERE")
      expect(parser.result.status).to eq(:empty)
      parser.result.status.should == :empty
    end
  end
end
