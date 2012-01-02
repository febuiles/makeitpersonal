class Playlist
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :username, :type => String
  field :start_date, :type => DateTime
  field :end_date, :type => DateTime
  field :songs, :type => Array

  validates_presence_of :username, :start_date, :end_date

  def songs
    LastFm::List.new(username).between(start_date, end_date)
  end
end
