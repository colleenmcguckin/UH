class CreateProgram < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :receiver_id
      t.string  :perishable_food_distribution
      t.string :charge_for_service
      t.string  :meal_style
      t.integer :staff_size
    end
  end
end
