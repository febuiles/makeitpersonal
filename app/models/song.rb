class Song < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  validates_presence_of :artist, :title, :lyrics
  friendly_id :title, :use => :slugged
end
