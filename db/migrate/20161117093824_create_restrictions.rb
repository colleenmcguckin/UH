class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.integer :category_id
      t.integer :receiver_id
    end
  end
end
