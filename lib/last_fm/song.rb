require 'json'

module LastFm
  class Song
    attr_reader :artist, :title, :art, :time

    def self.from_json(json)
      song = JSON.parse(json)
      Song.new(song["artist"], song["title"], song["art"], DateTime.parse(song["time"]))
    end

    def initialize(artist, title, art, time)
      @artist = artist
      @title = title
      @art = art
      @time = time
    end

    def played_between?(start_date, end_date)
      return false unless time
      time >= start_date && time <= end_date
    end

    def to_json
      { artist: artist, title: title, art: art, time: time.to_s }.to_json
    end
  end
end
