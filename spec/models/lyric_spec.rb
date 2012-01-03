require 'spec_helper'

describe Lyric do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Great Expectations" } }
  let(:fetcher) { double }
  subject { Lyric.from_params(params).text }

  before do
    fetcher.stub!(:fetch).and_return("ZOMGLYRICS")
    Lyrics::Fetcher.stub!(:new).and_return(fetcher)
    Lyric.destroy_all
  end

  context ".from_params" do
    it "returns the lyrics" do
      subject.should == "ZOMGLYRICS"
    end

    it "saves the lyrics to the database" do
      expect { subject }.to change(Lyric, :count).by(1)
    end

    it "formats the artist and title before saving them to the database" do
      subject

      key = Lyrics::KeyCreator.key_for(params)
      expect {
        Lyric.find_by_key(key)
      }.not_to raise_error
    end

    it "returns the lyrics from the database if the song already exists" do
      subject
      Lyrics::Fetcher.should_not_receive(:new)
      subject
    end
  end
end
