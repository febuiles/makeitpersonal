require 'spec_helper'
require 'lyrics/parser'

describe Lyric do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Great Expectations" } }
  let(:fetcher) { double }

  before do
    result = Lyrics::ParserResult.new(:ok, "ZOMGLYRICS")
    fetcher.stub!(:result).and_return(result)
    Lyrics::Fetcher.stub!(:new).and_return(fetcher)
    Lyric.destroy_all
  end

  context "callbacks" do
    let(:lyric) { Fabricate(:lyric) }

    it "formats the artist and title before saving them to the database" do
      lyric.artist.should == "the-gaslight-anthem"
      lyric.title.should == "great-expectations"
    end
  end

  context ".by_params" do
    it "formats the params array and returns the matching lyrics" do
      lyric = Fabricate(:lyric)
      Lyric.by_params(params).should == lyric
    end

    it "returns a new lyric if it can't find one" do
      lyric = Lyric.by_params(params)
      lyric.artist.should == params[:artist]
      lyric.title.should == params[:title]
      lyric.text.should be_nil
    end
  end

  context "#fetch_and_save" do
    let(:lyric) { Lyric.new(params) }

    it "returns the lyrics" do
      lyric.fetch_and_save
      lyric.text.should == "ZOMGLYRICS"
    end

    it "saves the new lyrics to the database" do
      expect { lyric.fetch_and_save }.to change(Lyric, :count).by(1)
    end

    it "doesn't save invalid lyrics in the database" do
      fetcher.stub(:result).and_return(Lyrics::ParserResult.new(:fail))
      lyric.fetch_and_save.should be_false
    end
  end
end
