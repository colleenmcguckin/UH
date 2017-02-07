class AddIntakeSurveyCompletedToReceivers < ActiveRecord::Migration
  def change
    add_column :receivers, :intake_survey_completed, :boolean
  end
end
