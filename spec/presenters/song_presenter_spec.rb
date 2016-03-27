require 'spec_helper'

describe SongPresenter do
  describe "#body" do
    it "replaces the sidenotes with bracketed numbers" do
      song = Song.new(lyrics: "I swear he's [[made of bone]]")
      expect(song.body).to eq("I swear he's <span class=\"sidenote-ref\">[1]</span>")
    end
  end

  describe "#embed" do
    it "doesn't raise an error if the youtube_url is empty" do
      expect { Song.new.embed }.not_to raise_error
    end

    it "is careful with XSS in the body of the song" do
      song = Song.new(lyrics: "<svg onload=alert(1) />difícil empresa[[srsly]]")
      expect(song.body).to eq("difícil empresa<span class=\"sidenote-ref\">[1]</span>")
    end

    it "is careful with XSS in the sidenotes" do
      song = Song.new(lyrics: "[[<svg onload=alert(1)/>]]")
      expect(song.sidenotes).to eq("<p><strong>[1]</strong> </p>\n")
    end
  end
end
