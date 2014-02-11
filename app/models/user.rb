class User < ActiveRecord::Base
  extend FriendlyId
  include UserPresenter

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  friendly_id :username, :use => :slugged
  acts_as_paranoid

  has_many :songs
  has_many :loves
  has_many :relationships, foreign_key: "follower_id", :dependent => :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship"
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships

  attr_accessor :login
  attr_accessible :email, :password, :remember_me, :login, :username, :twitter, :website, :name, :bio

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_format_of :username, :with => /^[\w_]+$/

  after_create :send_welcome_email

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def update_with_password(params={})
    params.delete(:password) if params[:password].blank?
    update_attributes(params)
  end

  def followers
    super.order("created_at DESC")
  end

  def followed_users
    super.order("created_at DESC")
  end

  def owns?(song)
    songs.exists?(id: song.id)
  end

  def follow(user)
    return if followed_users.include?(user)
    relationships.create!(followed_id: user.id)
  end

  def unfollow(user)
    return unless followed_users.include?(user)
    relationships.find_by_followed_id(user.id).destroy
  end

  def follows?(user)
    relationships.find_by_followed_id(user.id)
  end

  def timeline_songs
    _songs = songs.recent + followed_users.map(&:visible_recent_songs).flatten
    _songs.sort_by { |song| song.created_at.to_date }.reverse
  end

  def visible_recent_songs
    songs.visible.recent
  end

  def songs_visible_to(user)
    self == user ? songs.recent : visible_recent_songs
  end

  def sample_songs
    return [] if visible_recent_songs.length < 2
    visible_recent_songs.sample(3)
  end

  def trustable?
    songs.count > 30
  end

  def love(song)
    return if owns?(song) or loves?(song)
    loves.create!(:song_id => song.id)
  end

  def loved_songs
    loves.map(&:song)
  end

  def loves_by_date
    loves.order("created_at desc").group_by { |love| love.created_at.to_date }
  end

  def loves_received
    Love.find_all_by_owner_id(id).map(&:song).uniq
  end

  def loves?(song)
    loved_songs.include?(song)
  end

  private

  def send_welcome_email
    WelcomeMailer.welcome(self).deliver
  end
end
