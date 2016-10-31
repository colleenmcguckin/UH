class AddDetailsToReceiver < ActiveRecord::Migration
  def change
    add_column :receivers, :agency_name, :string
    add_column :receivers, :street_address, :string
    add_column :receivers, :city, :string
    add_column :receivers, :state, :string
    add_column :receivers, :zip, :integer
    add_column :receivers, :tax_id, :string
  end
end
