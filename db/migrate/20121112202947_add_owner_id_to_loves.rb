class AddOwnerIdToLoves < ActiveRecord::Migration
  def change
    add_column :loves, :owner_id, :integer
  end
end
