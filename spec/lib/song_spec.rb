require 'date'
require 'last_fm/song'

include LastFm

describe Song do
  let(:date){ Date.new(2012, 1, 1) }
  let(:song) { Song.new("The Gaslight Anthem", "Lucky", "fake.png", date) }

  context "song creation" do
    it "contains the artist, title, artwork and time played" do
      song.artist.should == "The Gaslight Anthem"
      song.title.should == "Lucky"
      song.art.should == "fake.png"
      song.time.should == date
    end
  end

  context "#to_json" do
    it "returns the JSON representation of the song" do
      values = JSON.parse(song.to_json)
      values["artist"].should == "The Gaslight Anthem"
      values["title"].should == "Lucky"
      values["art"].should == "fake.png"
      values["time"].should == "2012-01-01"
    end
  end

  context "#played_between?" do
    it "returns true if the song was played between start_date and end_date" do
      song.played_between?(DateTime.new(2011, 1, 1), DateTime.now).should be_true
    end

    it "returns false if the time for the song's not set" do
      song = Song.new(nil, nil, nil, nil)
      song.played_between?(mock, mock).should be_false
    end
  end
end
