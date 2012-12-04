require_relative "../../lib/youtube_parser"

describe YoutubeParser do
  describe "#embed_code" do
    it "returns the correct embed code for the YouTube video" do
      parser = YoutubeParser.new("http://www.youtube.com/watch?v=9-mi8xhanBI")
      parser.embed_code.should match(/src='http:\/\/www\.youtube\.com\/embed\/9-mi8xhanBI/)

      parser = YoutubeParser.new("http://www.youtube.com/watch?v=l242CWD3sdI")
      parser.embed_code.should match(/src='http:\/\/www\.youtube\.com\/embed\/l242CWD3sdI/)
    end

    it "ignores additional attributes" do
      parser = YoutubeParser.new("http://www.youtube.com/watch?v=b4N4qn8QyYo&feature=fvwrel")
      parser.embed_code.should match(/src='http:\/\/www\.youtube\.com\/embed\/b4N4qn8QyYo/)
      parser.embed_code.should_not match(/feature=fvwrel/)
    end
  end
end
