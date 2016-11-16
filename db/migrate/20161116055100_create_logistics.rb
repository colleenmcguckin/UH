class CreateLogistics < ActiveRecord::Migration
  def change
    create_table :logistics do |t|
      t.integer :receiver_id
      t.string :transportation_available
      t.string :driver_status
      t.string :insurance_status
      t.string :vehicle_style
      t.string :freezer_type
      t.string :refrigerator_type
      t.string :indoor_dry_storage
      t.string :safe_handling_program
      t.string :meal_usage
      t.string :meal_distribution_frequency
    end
  end
end
