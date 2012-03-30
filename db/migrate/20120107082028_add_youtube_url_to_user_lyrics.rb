class AddYoutubeUrlToUserLyrics < ActiveRecord::Migration
  def change
    add_column :user_lyrics, :youtube_url, :string
  end
end
