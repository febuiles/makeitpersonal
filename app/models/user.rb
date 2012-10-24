class User < ActiveRecord::Base
  has_many :songs
  extend FriendlyId

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  friendly_id :username, :use => :slugged

  attr_accessor :login
  attr_accessible :email, :password, :remember_me, :login, :username, :twitter, :website
  validates_presence_of :username
  validates_uniqueness_of :username
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

  def songs_by_date
    songs.group_by { |x| x.created_at.to_date }
  end

  def sample_songs
    samples = []
    return samples if songs.length < 2
    songs.sample(3)
  end

  private

  def send_welcome_email
    WelcomeMailer.welcome(self).deliver
  end
end
