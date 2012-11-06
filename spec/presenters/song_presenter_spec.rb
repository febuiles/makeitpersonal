require 'spec_helper'

describe SongPresenter do
  describe "body" do
  it "replaces the sidenotes with bracketed numbers" do
    song = Song.new(lyrics: "I swear he's [[made of bone]]")
    song.body.should == "I swear he's <span class='sidenote'>[1]</span>"
  end

  it "doesn't leave trailing sidenotes" do
    song = Song.new(lyrics: "I swear he's [[made of bone]]\n[[test]]")
    song.body.should == "I swear he's <span class='sidenote'>[1]</span>"
  end
  end

  describe "embed" do
    it "returns the embed code for the YouTube video" do
      song = Song.new(youtube_url: "http://www.youtube.com/watch?v=9-mi8xhanBI")
      song.embed.should match(/src='http:\/\/www\.youtube\.com\/embed\/9-mi8xhanBI/)

      song = Song.new(youtube_url: "http://www.youtube.com/watch?v=l242CWD3sdI")
      song.embed.should match(/src='http:\/\/www\.youtube\.com\/embed\/l242CWD3sdI/)
    end
  end
end
