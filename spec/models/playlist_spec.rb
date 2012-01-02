require 'spec_helper'

describe Playlist do
  context "callbacks" do
    let(:playlist) { Fabricate.build(:playlist) }

    before do
      stub_last_fm
    end

    it "fetches the lyrics and stores them in the songs field" do
      playlist.should_receive(:fetch_songs)
      playlist.save
    end

    it "saves the songs as an array of JSON objects" do
      playlist.save
      playlist.songs.should == %w(1 2 3)
    end
  end
end
