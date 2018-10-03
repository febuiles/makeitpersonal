require 'spec_helper'
require 'lyrics/parser'

describe Lyric do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Great Expectations" } }

  before do
    result = Lyrics::ParserResult.new(:ok, "ZOMGLYRICS")
    allow(Lyrics::WikiaService).to receive(:lyrics_for).and_return(result)
  end

  context "callbacks" do
    let(:lyric) { FactoryGirl.create(:lyric) }

    it "formats the artist and title before saving them to the database" do
      expect(lyric.artist).to eq("the-gaslight-anthem")
      expect(lyric.title).to eq("great-expectations")
    end

    it "strips empty spaces at the beginning and end" do
      lyric = Lyric.create!(artist: " Pink Floyd", title: "Not Now John ", text: "test")
      expect(lyric.artist).to eq("pink-floyd")
      expect(lyric.title).to eq("not-now-john")
    end
  end

  context ".by_params" do
    it "formats the params array and returns the matching lyrics" do
      lyric = FactoryGirl.create(:lyric)
      expect(Lyric.by_params(params)).to eq(lyric)
    end

    it "returns a new lyric if it can't find one" do
      lyric = Lyric.by_params(params)
      expect(lyric.artist).to eq(params[:artist])
      expect(lyric.title).to eq(params[:title])
      expect(lyric.text).to be_nil
    end
  end

  context "#fetch_and_save" do
    let(:lyric) { Lyric.new(params) }

    it "returns the lyrics" do
      lyric.fetch_and_save
      expect(lyric.text).to eq("ZOMGLYRICS")
    end

    it "saves the new lyrics to the database" do
      expect { lyric.fetch_and_save }.to change(Lyric, :count).by(1)
    end

    it "doesn't save invalid lyrics in the database" do
      allow(Lyrics::WikiaService).to receive(:lyrics_for) { Lyrics::ParserResult.new(:fail) }
      expect(lyric.fetch_and_save).to eq(false)
    end
  end
end
