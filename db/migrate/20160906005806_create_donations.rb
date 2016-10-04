class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer    :receiver_id
      t.integer    :donor_id
      t.string     :tracking_code
      t.timestamp  :confirmed_at
      t.timestamps true
    end
  end
end
