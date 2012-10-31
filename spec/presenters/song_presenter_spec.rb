require 'spec_helper'

describe SongPresenter do
  it "replaces the sidenotes with bracketed numbers" do
    song = Song.new(lyrics: "I swear he's [[made of bone]]")
    song.body.should == "I swear he's <span class='sidenote'>[1]</span>"
  end

  it "doesn't leave trailing sidenotes" do
    song = Song.new(lyrics: "I swear he's [[made of bone]]\n[[test]]")
    song.body.should == "I swear he's <span class='sidenote'>[1]</span>"
  end
end
