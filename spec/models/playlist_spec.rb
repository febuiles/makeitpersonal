require 'spec_helper'

describe Playlist do
  context "callbacks" do
    let(:playlist) do
      Playlist.new(:user => "febuiles", :start_date => Time.at(1324579382), :end_date => Time.now)
    end

    before do
      stub_last_fm
      playlist.stub!(:valid?).and_return(true)
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
