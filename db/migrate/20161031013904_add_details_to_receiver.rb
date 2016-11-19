class AddDetailsToReceiver < ActiveRecord::Migration
  def change
    add_column :receivers, :agency_name, :string
    add_column :receivers, :street_address, :string
    add_column :receivers, :city, :string
    add_column :receivers, :state, :string
    add_column :receivers, :zip, :integer
    add_column :receivers, :tax_id, :string
    add_column :receivers, :paused, :boolean, default: false
    add_column :receivers, :latitude, :float
    add_column :receivers, :longitude, :float
  end
end
