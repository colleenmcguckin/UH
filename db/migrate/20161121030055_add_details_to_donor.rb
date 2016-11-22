class AddDetailsToDonor < ActiveRecord::Migration
  def change
    add_column :donors, :agency_name, :string
    add_column :donors, :street_address, :string
    add_column :donors, :city, :string
    add_column :donors, :state, :string
    add_column :donors, :zip, :string
    add_column :donors, :contact_name, :string
    add_column :donors, :contact_email, :string
    add_column :donors, :contact_phone, :string
    add_column :donors, :web_url, :string
  end
end
