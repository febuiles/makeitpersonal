require 'fast_spec_helper'
require 'nokogiri'
require "last_fm/playlist"

include LastFm

describe Playlist do
  let(:playlist) { Playlist.new("febuiles") }
  let(:document) { Nokogiri::XML(open(File.dirname(__FILE__) + "/../fixtures/sample.xml")) }

  before do
    playlist.stub!(:document).and_return(document)
  end

  context "playlist creation" do
    it "contains the username" do
      playlist.user.should == "febuiles"
    end
  end

  context "document" do
    before { playlist.stub!(:refresh!).and_return(document) }

    it "returns the Nokogiri XML document" do
      playlist.document.should == document
    end
  end

  context "songs" do
    let(:songs) { playlist.songs }

    it "returns a list of the user songs" do
      songs.count.should == 201
      songs.first.should be_kind_of(Song)
    end
  end

  context "between" do
    let(:before) { Time.at(1324579382) }
    let(:after) { Time.at(1324616219) }

    it "returns the songs with date >= start_date" do
      songs = playlist.between(before, after)
      songs.each do |s|
        s.time.should >= before
      end
    end

    it "returns the songs with date <= end_date" do
      songs = playlist.between(before, after)
      songs.each do |s|
        s.time.should <= after
      end
    end
  end
end
