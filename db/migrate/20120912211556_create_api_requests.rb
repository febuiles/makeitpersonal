class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.string :endpoint
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
