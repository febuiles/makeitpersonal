class AddDataFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string
    add_column :users, :website, :string
  end
end
