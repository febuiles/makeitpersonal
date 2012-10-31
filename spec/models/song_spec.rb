require 'spec_helper'

describe Song do
  describe "incr" do
    it "increases the number of visits to this song" do
      Song.skip_callback(:create, :after, :send_notifications)
      song = Song.create(artist: "Talking Heads", title: "Once in a Lifetime", lyrics: "And you may find yourself living in a shotgun shack...")
      song.views.should == 0
      song.incr
      song.reload.views.should == 1
    end
  end
end
