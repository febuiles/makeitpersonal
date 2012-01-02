require 'spec_helper'

describe Playlist do
  context "callbacks" do
    let(:playlist) { Fabricate.build(:playlist) }

    it "fetches the lyrics and stores them in the songs field" do
      playlist.should_receive(:fetch_songs)
      playlist.save
    end
  end
end
