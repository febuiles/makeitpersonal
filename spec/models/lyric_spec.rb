require 'spec_helper'

describe Lyric do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Great Expectations" } }
  let(:fetcher) { double }

  before do
    fetcher.stub!(:lyrics).and_return("ZOMGLYRICS")
    Lyrics::Fetcher.stub!(:new).and_return(fetcher)
    Lyric.destroy_all
  end

  context ".by_params" do
    it "formats the params array and returns the matching lyrics" do
      lyric = Fabricate(:lyric)
      Lyric.by_params(params).should == lyric
    end
  end

  context ".from_params" do
    subject { Lyric.from_params(params).text }

    it "returns the lyrics" do
      subject.should == "ZOMGLYRICS"
    end

    it "saves the lyrics to the database" do
      expect { subject }.to change(Lyric, :count).by(1)
    end

    it "formats the artist and title before saving them to the database" do
      subject
      Lyric.by_params(params).artist.should == "the-gaslight-anthem"
      Lyric.by_params(params).title.should == "great-expectations"
    end

    it "returns the lyrics from the database if the song already exists" do
      subject
      Lyrics::Fetcher.should_not_receive(:new)
      subject
    end

    it "doesn't save invalid lyrics in the database" do
      fetcher.stub!(:lyrics).and_return("")
      expect {
        Lyric.from_params(params)
      }.not_to raise_error
    end
  end
end
