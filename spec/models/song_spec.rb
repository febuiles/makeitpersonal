require 'spec_helper'

describe Song do

  context "callbacks" do
    before { Song.skip_callback(:create, :after, :send_notifications) }

    describe "strip_song_info" do
      it "strips the artist and the song title before saving the record" do
        song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...")
        expect(song.artist).to eq("The Police")
        expect(song.title).to eq("On Any Other Day")

        song.update_attributes(artist: " The Police", title: "On Any Other Day ")

        expect(song.artist).to eq("The Police")
        expect(song.title).to eq("On Any Other Day")
      end
    end

    it "creates a random token if the song is hidden" do
      expect(SecureRandom).to receive(:hex)
      song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...", hidden: true)
    end

    it "doesn't update the slug of a private song on update" do
      song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...", hidden: true)
      original_slug = song.slug
      song.update_attributes(lyrics: "Some new lyrics with different markdown comments")
      expect(song.reload.slug).to eq(original_slug)
    end

    it "lets you update the song and creates a new slug if `hidden` changed" do
      allow(SecureRandom).to receive(:hex) { 'foo' }
      song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...")
      song.hidden = true
      song.save!

      expect(song.reload.slug).to eq('foo')
    end

    it "creates a readable slug if the song was hidden and is now public" do
      allow(SecureRandom).to receive(:hex) { 'foo' }
      song = Song.create!(artist: " The Police", title: "On Any Other Day ", lyrics: "There's a house on my street...", hidden: true)
      expect(song.slug).to eq('foo')
      song.hidden = false
      song.save

      expect(song.reload.slug).to eq('on-any-other-day')
    end
  end

  describe "#incr" do
    before { Song.skip_callback(:create, :after, :send_notifications) }

    it "increases the number of visits to this song" do
      song = Song.create(artist: "Talking Heads", title: "Once in a Lifetime", lyrics: "And you may find yourself living in a shotgun shack...")
      expect(song.views).to eq(0)
      song.incr
      expect(song.reload.views).to eq(1)
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
        expect(song.lovers).to eq([first, second])
      end
    end
  end
end
