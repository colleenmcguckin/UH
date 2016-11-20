class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.string :description
      t.string :storage_temp
      t.boolean :prepared_meal, default: false
      t.integer :donor_id
      t.integer :category_id
    end
  end
end
