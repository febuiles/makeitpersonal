require 'open-uri'
require 'parser'
require 'song'

module LastFm
  class List
    include Enumerable

    attr_reader :user, :document

    def initialize(user, mock_call=false)
      @user = user
      mock_document if mock_call
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
      @songs = songs.find_all { |song| song.played_between?(start_date, end_date) }
      self
    end

    def refresh!
      url = "http://ws.audioscrobbler.com/2.0/user/#{user}/recenttracks.xml?limit=200"
      @songs = nil
      @document = Nokogiri::XML(open(url))
    end

    def to_json
      songs.map(&:to_json)
    end

    def each(&block)
      songs.each do |song|
        yield(song)
      end
    end

    private

    def mock_document
      @document = Nokogiri::XML(open(File.dirname(__FILE__) + "/../../spec/fixtures/sample.xml"))
    end
  end
end
