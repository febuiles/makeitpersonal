class Playlist
  include Mongoid::Document, Mongoid::MultiParameterAttributes
  include SongPersistable

  field :username, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :songs, :type => Array

  validates_presence_of :username, :start_date, :end_date

  before_save :fetch_songs
end
