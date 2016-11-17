class CreateRestrictionsStorageTemps < ActiveRecord::Migration
  def change
    create_table :restrictions_storage_temps do |t|
      t.integer :restriction_id
      t.integer :storage_temp_id
    end
  end
end
