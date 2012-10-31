class RenameVisitsToViews < ActiveRecord::Migration
  def up
    rename_column :songs, :visits, :views
  end

  def down
    rename_column :songs, :views, :visits
  end
end
