require 'fast_spec_helper'
require 'lyrics/fetcher'
require 'active_support/inflector'
include ActiveSupport::Inflector, Lyrics

describe Fetcher do
  let(:fetcher) { Fetcher.new("The Gaslight anthem", "great expectations")}

  context "artist and song names" do
    it "has getters for artist format the strings" do
      fetcher.artist.should == "The_Gaslight_Anthem"
    end

    it "has getters for title format the strings" do
      fetcher.title.should == "Great_Expectations"
    end
  end

  context "#lyrics"  do
    let(:document) { File.dirname(__FILE__) + "/../../fixtures/song.html" }

    before do
      fetcher.stub!(:text_from_wikia).and_return(Nokogiri::HTML(open(document)))
    end

    it "fetches the lyrics from Wikia" do
      fetcher.should_receive(:text_from_wikia)
      fetcher.lyrics
    end

    it "parses the document and returns the lyrics" do
      fetcher.lyrics.should == "\nZOMGLYRICS\n"
    end

    it "returns blank if no lyrics exist for the song" do
      fake_document = File.dirname(__FILE__) + "/../../fixtures/song_doesnt_exist.html"
      fetcher.stub!(:text_from_wikia).and_return(Nokogiri::HTML(open(fake_document)))
      fetcher.lyrics.should == ""
    end

    it "returns blank if the page doesn't contain any lyrics div" do
      fake_document = File.dirname(__FILE__) + "/../../fixtures/song_with_redirect.html"
      fetcher.stub!(:text_from_wikia).and_return(Nokogiri::HTML(open(fake_document)))
      fetcher.lyrics.should == ""
    end
  end
end
