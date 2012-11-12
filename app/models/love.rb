class Love < ActiveRecord::Base
  belongs_to :user
  belongs_to :song

  attr_accessible :song_id, :user_id

  before_create :add_owner_id

  private
  def add_owner_id
    self.owner_id = song.user.id
  end
end
