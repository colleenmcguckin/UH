class AddVerifiedAtToReceivers < ActiveRecord::Migration
  def change
    add_column :receivers, :verified_at, :datetime
  end
end
