require 'spec_helper'

describe SongPresenter do
  describe "body" do
    it "replaces the sidenotes with bracketed numbers" do
      song = Song.new(lyrics: "I swear he's [[made of bone]]")
      song.body.should == "I swear he's <span class='sidenote-ref'>[1]</span>"
    end
  end
end
