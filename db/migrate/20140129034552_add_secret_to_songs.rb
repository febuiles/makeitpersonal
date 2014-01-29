class AddSecretToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :hidden, :boolean, default: false
  end
end
