class FixIndices < ActiveRecord::Migration
  def up
    remove_index :relationships, :follower_id
    add_index :lyrics, :title
  end

  def down
    remove_index :lyrics, :title
    add_index :relationships, :follower_id
  end
end
