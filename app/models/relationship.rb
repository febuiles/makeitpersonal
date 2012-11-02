class Relationship < ActiveRecord::Base
  belongs_to :user
  attr_accessible :follower_id
  belongs_to :follower, :class_name => "User"
  belongs_to:followed_user, :class_name => "User"
end
