class User < ActiveRecord::Base
  has_many :songs
  has_many :relationships, :foreign_key => "follower_id"
  has_many :followed_users, through: :relationships, :dependent => :destroy
  has_many :followers, through: :relationships, :source => :follower, :dependent => :destroy

  extend FriendlyId
  include UserPresenter

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  friendly_id :username, :use => :slugged

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

  def owns?(song)
    songs.include?(song)
  end

  def follow(user)
    return if followed_users.include?(user)
    followed_users << user
  end

  def unfollow(user)
    return unless followed_users.include?(user)
    relationships.find_by_followed_user_id(user.id).destroy
  end

  def follows?(user)
    followed_users.include?(user)
  end

  def timeline_songs
    songs = recent_songs + followed_users.map(&:recent_songs).flatten
    songs.group_by { |x| x.created_at.to_date }
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

  private

  def send_welcome_email
    WelcomeMailer.welcome(self).deliver
  end
end
