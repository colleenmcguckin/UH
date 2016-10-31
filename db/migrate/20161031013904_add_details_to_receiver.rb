class AddDetailsToReceiver < ActiveRecord::Migration
  def change
    add_column :receivers, :agency_name, :string
    add_column :receivers, :street_address, :string
    add_column :receivers, :city, :string
    add_column :receivers, :state, :string
    add_column :receivers, :zip, :integer
    add_column :receivers, :tax_id, :string
    add_column :receivers, :contact_name, :string
    add_column :receivers, :contact_email, :string
    add_column :receivers, :contact_phone, :string
    add_column :receivers, :dfr_contact_name, :string
    add_column :receivers, :dfr_contact_email, :string
    add_column :receivers, :dfr_contact_office_phone, :string
    add_column :receivers, :dfr_contact_cell_phone, :string
    add_column :receivers, :dfr_preffered_contact_method, :string

  end
end
