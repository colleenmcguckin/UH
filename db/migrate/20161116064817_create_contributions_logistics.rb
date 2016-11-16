class CreateContributionsLogistics < ActiveRecord::Migration
  def change
    create_table :contributions_logistics do |t|
      t.integer :logistic_id
      t.integer :contribution_id
    end
  end
end
