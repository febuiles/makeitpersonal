class AddVisitsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :visits, :integer, :default => 0
  end
end
