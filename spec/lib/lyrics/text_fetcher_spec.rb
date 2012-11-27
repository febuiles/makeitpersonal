# -*- coding: utf-8 -*-
require 'fast_spec_helper'
require 'lyrics/text_fetcher'
include Lyrics

describe TextFetcher do
  let(:fetcher) { TextFetcher.new("The Gaslight anthem", "great expectations")}

  context "artist and song names" do
    it "formats the artist and the title" do
      fetcher.artist.should == "The_Gaslight_Anthem"
      fetcher.title.should == "Great_Expectations"
    end

    it "cleans the artist and song title" do
      fetcher = TextFetcher.new(" The Gaslight anthem ", " great expectations ")
      fetcher.artist.should == "The_Gaslight_Anthem"
      fetcher.title.should == "Great_Expectations"
    end
  end

  context "#lyrics_url" do
    it "encodes the url" do
      fetcher = TextFetcher.new("Kraftwerk", "Geigerzähler")
      fetcher.lyrics_url.should == "http://lyrics.wikia.com/index.php?title=Kraftwerk:Geigerz%C3%A4hler&action=edit"
    end

    it "accepts ampersands in the artist's name" do
      fetcher = TextFetcher.new("Coheed & Cambria", "Neverender")
      fetcher.lyrics_url.should == "http://lyrics.wikia.com/index.php?title=Coheed_%26_Cambria:Neverender&action=edit"
    end

    it "accepts ampersands in the song's name" do
      fetcher = TextFetcher.new("Coheed & Cambria", "Always & Never")
      fetcher.lyrics_url.should == "http://lyrics.wikia.com/index.php?title=Coheed_%26_Cambria:Always_%26_Never&action=edit"
    end
  end
end
