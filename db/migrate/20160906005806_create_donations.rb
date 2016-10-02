class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string     :tracking_code
      t.timestamp  :confirmed_at
      t.timestamps true
    end
  end
end
