require 'spec_helper'

describe Song do

  context "callbacks" do
    before { Song.skip_callback(:create, :after, :send_notifications) }

    describe "strip_song_info" do
      it "strips the artist and the song title before saving the record" do
        song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...")
        song.artist.should == "The Police"
        song.title.should == "On Any Other Day"
        song.update_attributes(artist: " The Police", title: "On Any Other Day ")
        song.artist.should == "The Police"
        song.title.should == "On Any Other Day"
      end

      it "creates a random token if the song is hidden" do
        SecureRandom.should_receive(:hex)
        song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...", hidden: true)
      end
    end
  end

  describe "#incr" do
    before { Song.skip_callback(:create, :after, :send_notifications) }

    it "increases the number of visits to this song" do
      song = Song.create(artist: "Talking Heads", title: "Once in a Lifetime", lyrics: "And you may find yourself living in a shotgun shack...")
      song.views.should == 0
      song.incr
      song.reload.views.should == 1
    end
  end

  context "loves" do
    describe "#lovers" do
      let(:song) { FactoryGirl.create(:song) }
      let(:first) { FactoryGirl.create(:user) }
      let(:second) { FactoryGirl.create(:user) }

      before do
        first.love(song)
        second.love(song)
      end

      it "returns a list of the users that loved a song" do
        song.lovers.should == [first, second]
      end
    end
  end
end
