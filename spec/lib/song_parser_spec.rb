require_relative "../../lib/song_parser"

describe SongParser do
  describe "#sidenotes" do
    it "returns the sidenotes as html" do
      parser = SongParser.new("I swear he's [[made of stone]], and [[I am]]")
      expect(parser.sidenotes).to eq("<p><strong>[1]</strong> made of stone</p>\n<p><strong>[2]</strong> I am</p>\n")
    end

    it "returns an empty array if no sidenotes are found" do
      parser = SongParser.new("I swear he's made of stone")
      expect(parser.sidenotes).to be_empty
    end
  end

  describe "#body" do
    it "returns the lyrics with the <em> tags" do
      parser = SongParser.new("This is my *advice*")
      expect(parser.lyrics).to eq("This is my <em>advice</em>")
    end
  end
end
