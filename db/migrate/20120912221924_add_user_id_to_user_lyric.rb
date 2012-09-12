class AddUserIdToUserLyric < ActiveRecord::Migration
  def change
    add_column :user_lyrics, :user_id, :integer

  end
end
