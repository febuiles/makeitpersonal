class User < ActiveRecord::Base
  extend FriendlyId
  include UserPresenter

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  friendly_id :username, :use => :slugged

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
    songs.include?(song)
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
    songs = recent_songs + followed_users.map(&:recent_songs).flatten
    songs.group_by { |x| x.created_at.to_date }.sort.reverse
  end

  def recent_songs
    songs.order("created_at DESC")
  end

  def recent_songs_by_date
    recent_songs.group_by { |x| x.created_at.to_date }
  end

  def sample_songs
    samples = []
    return samples if songs.length < 2
    songs.sample(3)
  end

  def blank_profile?
    [:twitter, :website, :name, :bio].each do |field|
      return false if send(field).present?
    end
    true
  end

  def love(song)
    return if owns?(song) or loves?(song)
    loves.create!(:song_id => song.id)
  end

  def loved_songs
    loves.map(&:song)
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
