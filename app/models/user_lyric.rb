class UserLyric < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :artist, :title, :lyrics
end
