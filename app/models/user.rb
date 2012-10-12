class User < ActiveRecord::Base
  has_many :songs

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :username

  validates_uniqueness_of :username

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def owns?(song)
    songs.include?(song)
  end
end
