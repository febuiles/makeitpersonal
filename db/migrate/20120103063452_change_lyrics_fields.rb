class ChangeLyricsFields < ActiveRecord::Migration
  def up
    add_column :lyrics, :artist, :string
    add_column :lyrics, :title, :string
    remove_column :lyrics, :key
  end

  def down
    add_column :lyrics, :key, :string
    remove_column :lyrics, :artist
    remove_column :lyrics, :title
  end
end
