class AddIndexToDb < ActiveRecord::Migration
  def change
    add_index :donation_items, :donation_id
    add_index :donations, [:receiver_id, :donor_id]
  end
end
