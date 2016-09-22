class CreateDonationItems < ActiveRecord::Migration
  def change
    create_table :donation_items do |t|
      t.string :description
      t.integer :quantity
      t.string :quantity_type
      t.integer :donation_id
    end
  end
end
