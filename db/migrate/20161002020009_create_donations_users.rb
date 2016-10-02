class CreateDonationsUsers < ActiveRecord::Migration
  def change
    create_table :donations_users do |t|
      t.integer    :receiver_id
      t.integer    :donor_id
      t.integer    :donation_id
    end
  end
end
