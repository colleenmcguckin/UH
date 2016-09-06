class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :user_id
      t.timestamps true
    end
  end
end
