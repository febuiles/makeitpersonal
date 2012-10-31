class RemoveUsernameFromSong < ActiveRecord::Migration
  def up
    remove_column :songs, :username
  end

  def down
    add_column :songs, :username, :string
  end
end
