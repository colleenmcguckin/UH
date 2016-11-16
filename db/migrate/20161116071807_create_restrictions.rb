class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.integer :receiver_id
      t.integer :category_id
      t.boolean :restrict_entire_category
      t.string :food_id
    end
  end
end
