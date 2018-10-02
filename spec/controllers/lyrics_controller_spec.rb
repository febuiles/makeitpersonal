require 'spec_helper'

describe LyricsController do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Not so great expectations" } }
  let(:lyric) { Lyric.new }

  context "lyric fetching" do
    before do
      Lyric.should_receive(:by_params).and_return(lyric)
    end

    it "returns the lyrics if they exists" do
      expect(lyric).to receive(:fetch_and_save).and_return(true)

      get :lyrics, params
      response.should render_template("lyrics/_lyric")
    end

    it "returns an error message if the lyrics weren't found" do
      lyric.text = "ohnoes"
      expect(lyric).to receive(:fetch_and_save).and_return(false)

      get :lyrics, params
      response.body.should == "ohnoes"
    end
  end

  context "missing params" do
    it "returns an error message if the song title is empty" do
      get :lyrics, { :artist => "Fubar" }
      response.body.should == "Invalid params"
      response.code.should == "422"
    end

    it "returns an error message if the artist is empty" do
      get :lyrics, { :title => "Fubar" }
      response.body.should == "Invalid params"
      response.code.should == "422"
    end
  end
end
