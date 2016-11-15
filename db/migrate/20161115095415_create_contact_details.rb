class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :dfr_contact_name
      t.string :dfr_contact_email
      t.string :dfr_contact_office_phone
      t.string :dfr_contact_cell_phone
      t.string :dfr_preffered_contact_method
      t.integer :receiver_id
    end
  end
end
