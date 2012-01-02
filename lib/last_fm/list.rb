require 'open-uri'
require 'parser'
require 'song'

module LastFm
  class List

    attr_reader :user, :document

    def initialize(user)
      @user = user
    end

    def songs
      return @songs unless @songs.nil?

      songs = document.css("recenttracks").css("track").map do |track|
        row = Parser::TrackRow.new(track)
        Song.new(row.artist, row.title, row.art, row.time)
      end

      @songs = songs
    end

    def document
      @document || refresh!
    end

    def between(start_date, end_date)
      @songs = songs.find_all { |s| s.time > start_date && s.time < end_date }
    end

    def refresh!
      url = "http://ws.audioscrobbler.com/2.0/user/#{user}/recenttracks.xml?limit=200"
      @songs = nil
      @document = Nokogiri::XML(open(url))
    end

    def to_json
      songs.map(&:to_json)
    end
  end
end
