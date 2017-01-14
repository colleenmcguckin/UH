class AddDetailsToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :total_weight, :string
    add_column :donations, :total_value_dollars, :integer
    add_column :donations, :total_value_cents, :integer
    add_column :donations, :total_meals, :integer
  end
end
