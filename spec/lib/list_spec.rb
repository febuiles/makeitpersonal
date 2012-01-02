require 'fast_spec_helper'
require "last_fm/list"

include LastFm

describe List do
  let(:playlist) { List.new("febuiles") }
  let(:document) { Nokogiri::XML(open(File.dirname(__FILE__) + "/../fixtures/sample.xml")) }

  before do
    playlist.stub!(:document).and_return(document)
  end

  context "playlist creation" do
    it "contains the username" do
      playlist.user.should == "febuiles"
    end
  end

  context "#document" do
    before { playlist.stub!(:refresh!).and_return(document) }

    it "returns the Nokogiri XML document" do
      playlist.document.should == document
    end
  end

  context "#songs" do
    let(:songs) { playlist.songs }

    it "returns a list of the user songs" do
      songs.count.should == 201
      songs.first.should be_kind_of(Song)
    end
  end

  context "#between" do
    let(:before) { Time.at(1324579382) }
    let(:after) { Time.at(1324616219) }
    let!(:songs) { playlist.between(before, after) }

    it "modifies the playlist" do
      playlist.songs.count.should == 146
    end

    it "returns the songs with date >= start_date" do
      songs.each do |s|
        s.time.should >= before
      end
    end

    it "returns the songs with date <= end_date" do
      songs.each do |s|
        s.time.should <= after
      end
    end

    it "returns the playlist" do
      songs.should be_kind_of(List)
    end
  end

  context "#to_json" do
    subject { playlist.to_json }
    it { should be_kind_of(Array) }
  end
end
