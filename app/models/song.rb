class Song < ActiveRecord::Base
  include SongPresenter
  extend FriendlyId

  scope :recent, order("id DESC")

  belongs_to :user
  validates_presence_of :artist, :title, :lyrics
  friendly_id :title, :use => :scoped, :scope => :user
  after_create :send_notifications

  def should_generate_new_friendly_id?
    new_record?
  end

  def incr
    update_attribute(:views, views + 1)
  end

  private
  def send_notifications
    SongMailer.new_song(self).deliver
  end
end
