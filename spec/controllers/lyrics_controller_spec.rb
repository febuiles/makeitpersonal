require 'spec_helper'

describe LyricsController do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Not so great expectations" } }
  let(:lyric) { mock(:text => "ZOMGLYRICS")}

  before do
    Lyric.should_receive(:by_params).and_return(lyric)
  end

  context "lyrics" do
    it "returns the lyrics if they exists" do
      lyric.stub!(:fetch_and_save).and_return(true)

      get :lyrics, params
      response.body.should == "ZOMGLYRICS"
    end

    it "returns an error message if the lyrics weren't found" do
      lyric.stub!(:fetch_and_save).and_return(false)

      get :lyrics, params
      response.body.should == "Sorry, we don't have any lyrics for this song"
    end
  end
end
