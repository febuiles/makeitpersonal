class AddSecretToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :secret, :boolean, default: false
  end
end
