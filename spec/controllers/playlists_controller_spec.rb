require 'spec_helper'

describe PlaylistsController do
  describe "#fetch" do
    let(:params) do {
        :username => "febuiles",
        :start_date => Time.now,
        :end_date => Time.now
      }
    end

    it "creates a new playlist" do
      expect {
        post :fetch, :playlist => params
      }.to change(Playlist, :count).by(1)

    end

    it "renders the playlist partial" do
      post :fetch, :playlist => params
      response.should render_template("playlists/_playlist")
    end

    it "shows an error the list's not valid" do
      post :fetch
      response.body.should == "Error loading the data."
    end
  end
end
