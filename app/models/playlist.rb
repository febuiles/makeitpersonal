class Playlist
  include Mongoid::Document
  field :username, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :songs, :type => Array

  validates_presence_of :username, :start_date, :end_date



  def fetch
    self.songs = PlaylistFetch::FetchService.new(username, start_date, end_date).songs
  end
end
