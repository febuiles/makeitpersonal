require 'open-uri'
require 'parser'
require 'song'

module LastFm
  class Playlist
    include Parser

    attr_reader :user, :document

    def initialize(user)
      @user = user
    end

    def songs
      return @songs unless @songs.nil?
      songs = []

      document.css("recenttracks").css("track").each do |track|
        artist = track.css("artist").first.content
        name = track.css("name").first.content
        art = track.css("image[size='small']").first.content
        time = track.css("date")
        time = time_from_row(time)
        songs << Song.new(artist, name, art, time)
      end
      @songs = songs
    end

    def document
      @document || refresh!
    end

    def refresh!
      url = "http://ws.audioscrobbler.com/2.0/user/#{user}/recenttracks.xml?limit=200"
      @document = Nokogiri::XML(open(url))
    end

    def between(start_date, end_date)
      songs.find_all { |s| s.time > start_date && s.time < end_date }
    end
  end
end
