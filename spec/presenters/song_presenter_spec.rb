require 'spec_helper'

describe SongPresenter do
  describe "body" do
    it "replaces the sidenotes with bracketed numbers" do
      song = Song.new(lyrics: "I swear he's [[made of bone]]")
      song.body.should == "I swear he's <span class='sidenote'>[1]</span>"
    end
  end

  describe "embed" do
    it "returns the correct embed code for the YouTube video" do
      song = Song.new(youtube_url: "http://www.youtube.com/watch?v=9-mi8xhanBI")
      song.embed.should match(/src='http:\/\/www\.youtube\.com\/embed\/9-mi8xhanBI/)

      song = Song.new(youtube_url: "http://www.youtube.com/watch?v=l242CWD3sdI")
      song.embed.should match(/src='http:\/\/www\.youtube\.com\/embed\/l242CWD3sdI/)

      song = Song.new(youtube_url: "http://www.youtube.com/watch?v=b4N4qn8QyYo&feature=fvwrel")
      song.embed.should match(/src='http:\/\/www\.youtube\.com\/embed\/b4N4qn8QyYo\?rel/)
      song.embed.should_not match(/feature=fvwrel/)
    end
  end
end
