class Song < ActiveRecord::Base
  include SongPresenter
  extend FriendlyId

  scope :recent, order("created_at DESC")

  belongs_to :user
  validates_presence_of :artist, :title, :lyrics
  friendly_id :title, :use => :scoped, :scope => :user




  def should_generate_new_friendly_id?
    new_record?
  end
end
