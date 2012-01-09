require 'nokogiri'
require "last_fm/parser"

include LastFm

describe Parser do
  include LastFm::Parser
  let(:row) { Nokogiri::XML(open(File.dirname(__FILE__) + "/../../fixtures/song.xml")) }
  let(:track) { TrackRow.new(row) }

  before do
    Time.stub!(:now).and_return(Time.new(2012, 1, 1))
  end

  context "initialization" do
    it "sets the row's data" do
      track.artist.should == "Def Leppard"
      track.title.should == "Coming Under Fire"
      track.art.should == "http://userserve-ak.last.fm/serve/34s/29447933.png"
      track.time.should == Time.at(1324615964)
    end
  end
end
