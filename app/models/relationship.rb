class Relationship < ActiveRecord::Base
  belongs_to :user
  attr_accessible :follower_id, :followed_id

  validates_presence_of :follower_id, :followed_id

  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
end
