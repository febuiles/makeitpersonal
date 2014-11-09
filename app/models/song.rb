require 'securerandom'

class Song < ActiveRecord::Base
  include SongPresenter
  extend FriendlyId

  friendly_id :slug_creator, :use => :scoped, :scope => :user

  has_many :loves
  belongs_to :user

  validates_presence_of :artist, :title, :lyrics
  before_save   :strip_song_info
  after_create  :send_notifications, :unless => :hidden?

  scope :recent, order("created_at DESC")
  scope :hidden, where(:hidden => true)
  scope :visible, where(:hidden => false)
  scope :count_grouped_by_day, select("count(*), date(created_at)").group("date(created_at)").order(:date)

  def should_generate_new_friendly_id?
    new_record?
  end

  def incr
    update_attribute(:views, views + 1)
  end

  def lovers
    loves.map(&:user)
  end


  private

  def should_generate_new_friendly_id?
    self.new_record? || self.hidden_changed?
  end

  def slug_creator
    hidden? ? SecureRandom.hex(32) : title
  end

  def send_notifications
    SongMailer.new_song(self).deliver
  end

  def strip_song_info
    self.artist = artist.strip
    self.title = title.strip
  end
end
