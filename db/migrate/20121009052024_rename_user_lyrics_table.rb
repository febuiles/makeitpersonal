class RenameUserLyricsTable < ActiveRecord::Migration
  def up
    rename_table :user_lyrics, :songs
  end

  def down
    rename_table :songs, :user_lyrics
  end
end
