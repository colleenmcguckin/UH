class CreateDietaryRestrictionsPrograms < ActiveRecord::Migration
  def change
    create_table :dietary_restrictions_programs do |t|
      t.integer :program_id
      t.integer :dietary_restriction_id
    end
  end
end
