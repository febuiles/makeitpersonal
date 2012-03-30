class UserLyric < ActiveRecord::Base
  validates_presence_of :artist, :title, :lyrics
end
