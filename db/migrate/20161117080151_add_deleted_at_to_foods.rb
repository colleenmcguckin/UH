class AddDeletedAtToFoods < ActiveRecord::Migration
  def change
    add_column :foods, :deleted_at, :datetime
    add_index :foods, :deleted_at
  end
end
