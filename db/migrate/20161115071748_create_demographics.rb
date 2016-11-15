class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.string :percent_male
      t.string :percent_female
      t.string :percent_other_gender
      t.string :percent_youth
      t.string :percent_adult
      t.string :percent_senior
      t.string :percent_american_native
      t.string :percent_african_american
      t.string :percent_asian
      t.string :percent_hispanic
      t.string :percent_pacific_islander
      t.string :percent_white
      t.string :percent_portuguese
      t.string :percent_single_no_kids
      t.string :percent_single_with_kids
      t.string :percentage_married_no_kids
      t.string :percentage_married_with_kids
      t.string :precent_employed
      t.string :percent_unemployed
      t.string :percent_veteran_military
      t.string :percent_active_military
      t.string :percentage_with_dietary_restrictions
      t.integer :total_guests_served_per_week
      t.integer :meals_served_per_breakfast
      t.integer :meals_served_per_lunch
      t.integer :meals_served_per_dinner
      t.integer :total_receiving_groceries
      t.string :mode_of_transportation
      t.string :distance_traveled
      t.integer :receiver_id
    end
  end
end
