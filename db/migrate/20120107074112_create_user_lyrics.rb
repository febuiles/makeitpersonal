class CreateUserLyrics < ActiveRecord::Migration
  def change
    create_table :user_lyrics do |t|
      t.text :lyrics
      t.string :artist
      t.string :title
      t.string :username

      t.timestamps
    end
  end
end
