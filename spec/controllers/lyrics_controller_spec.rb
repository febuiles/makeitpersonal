require 'spec_helper'

describe LyricsController do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Great Expectations" } }

  context "lyrics" do
    it "returns the lyrics if they exists" do
      Lyric.should_receive(:from_params).and_return(mock(:text => "ZOMGLYRICS"))
      get :lyrics, params
      response.body.should == "ZOMGLYRICS"
    end

    it "returns an error message if the lyrics weren't found" do
      Lyric.should_receive(:from_params).and_return(nil)
      get :lyrics, params
      response.body.should == "Sorry, we don't have any lyrics for this song"
    end
  end
end
