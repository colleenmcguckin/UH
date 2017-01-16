class AddPercentOtherToDemographics < ActiveRecord::Migration
  def change
    add_column :demographics, :percent_other_nationality, :string
  end
end
