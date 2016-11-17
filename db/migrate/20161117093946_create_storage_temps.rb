class CreateStorageTemps < ActiveRecord::Migration
  def change
    create_table :storage_temps do |t|
      t.string :description
    end
  end
end
