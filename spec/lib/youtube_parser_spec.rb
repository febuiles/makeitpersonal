require_relative "../../lib/youtube_parser"

describe YoutubeParser do
  describe "#embed_code" do
    it "returns the correct embed code for the YouTube video" do
      parser = YoutubeParser.new("https://www.youtube.com/watch?v=9-mi8xhanBI")
      expect(parser.embed_code).to match(/youtube\.com\/embed\/9-mi8xhanBI/)

      parser = YoutubeParser.new("https://www.youtube.com/watch?v=l242CWD3sdI")
      expect(parser.embed_code).to match(/youtube\.com\/embed\/l242CWD3sdI/)
    end

    it "ignores additional attributes" do
      parser = YoutubeParser.new("https://www.youtube.com/watch?v=b4N4qn8QyYo&feature=fvwrel")
      expect(parser.embed_code).to match(/youtube\.com\/embed\/b4N4qn8QyYo/)
      expect(parser.embed_code).not_to match(/feature=fvwrel/)
    end
  end
end
