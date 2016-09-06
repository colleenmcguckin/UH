class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :role
      t.string :first_name
      t.string :last_name
      t.string :organization_name
      t.timestamps true
    end
  end
end
