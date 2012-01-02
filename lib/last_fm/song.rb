module LastFm
  class Song
    attr_reader :artist, :title, :art, :time

    def initialize(artist, title, art, time)
      @artist = artist
      @title = title
      @art = art
      @time = time
    end

    def to_json
      { artist: artist, title: title, art: art, time: time.to_s }.to_json
    end
  end
end
