class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :role
    end
  end
end
