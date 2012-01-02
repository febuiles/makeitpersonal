class Playlist
  include Mongoid::Document, Mongoid::MultiParameterAttributes

  field :username, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :songs, :type => Array

  validates_presence_of :username, :start_date, :end_date

  before_save :fetch_songs

  def fetch_songs
    self.songs = LastFm::List.new(username, Rails.env != "production").between(start_date, end_date).to_json
  end
end
