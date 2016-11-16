class CreateDietaryRestrictions < ActiveRecord::Migration
  def change
    create_table :dietary_restrictions do |t|
      t.string :name
    end
  end
end
