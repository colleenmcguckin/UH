class CreateDonationSchedules < ActiveRecord::Migration
  def change
    create_table :donation_schedules do |t|
      t.integer :receiver_id
      t.integer :day_of_week
      t.integer :open_at_hour
      t.integer :open_at_minute
      t.integer :close_at_hour
      t.integer :close_at_minute
    end
  end
end
