class CreateCategoriesRestrictions < ActiveRecord::Migration
  def change
    create_table :categories_restrictions do |t|
      t.integer :category_id
      t.integer :restriction_id
    end
  end
end
