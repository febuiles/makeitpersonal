class Love < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  attr_accessible :song_id, :user_id
end
