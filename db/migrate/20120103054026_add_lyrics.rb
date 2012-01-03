class AddLyrics < ActiveRecord::Migration
  def up
    create_table :lyrics do |t|
      t.string :key
      t.text :text
    end
  end

  def down
    drop_table :lyrics
  end
end
