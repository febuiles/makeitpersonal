
module PlaylistFetch
  class Song
    attr_reader :artist, :title, :art, :time

    def initialize(artist, title, art, time)
      @artist = artist
      @title = title
      @art = art
      @time = time
    end

    def to_json
      { artist: artist, song: song, art: art, time: time }.to_json
    end
  end

  class FetchService
    attr_reader :songs
    LAST_FM_URL = "http://ws.audioscrobbler.com/2.0/user/{{user}}/recenttracks.xml?limit=200"

    def initialize(user, start_date, end_date)

      @songs = []

      url = LAST_FM_URL.sub("{{user}}", user)
      document = Nokogiri.XML(open(url))
      document.css("recenttracks").css("track").each do |track|
        artist = track.css("artist").first.content
        name = track.css("name").first.content
        art = track.css("image[size='medium']").first.content
        time = parse_time(track)
        songs << Song.new(artist, name, art, time)
      end
    end

    def to_playlist
      songs.map(&:to_json)
    end

    private

    def parse_time(track)
      begin
        time = track.css("date").attr("uts").value.to_i
        Time.at(time)
      rescue NoMethodError
        Time.now
      end
    end
  end
end
