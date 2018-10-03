require 'spec_helper'

describe LyricsController do
  let(:params) { { :artist => "The Gaslight Anthem", :title => "Not so great expectations" } }
  let(:lyric) { Lyric.new }

  context "lyric fetching" do
    before do
      expect(Lyric).to receive(:by_params) { lyric }
    end

    it "returns the lyrics if they exists" do
      expect(lyric).to receive(:fetch_and_save) { true }

      get :lyrics, params
      expect(response).to render_template("lyrics/_lyric")
    end

    it "returns an error message if the lyrics weren't found" do
      lyric.text = "ohnoes"
      expect(lyric).to receive(:fetch_and_save).and_return(false)

      get :lyrics, params
      expect(response.body).to eq('ohnoes')
    end
  end

  context "missing params" do
    it "returns an error message if the song title is empty" do
      get :lyrics, { :artist => "Fubar" }
      expect(response.body).to eq("Invalid params")
      expect(response.code).to eq("422")
    end

    it "returns an error message if the artist is empty" do
      get :lyrics, { :title => "Fubar" }
      expect(response.body).to eq("Invalid params")
      expect(response.code).to eq("422")
    end
  end
end
