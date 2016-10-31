class DonationSchedule < ActiveRecord::Base
  belongs_to :receiver

  DAYS_IN_WORDS = %w[sunday monday tuesday wednesday thursday friday saturday]

  validates :day_of_week, uniqueness: { scope: :receiver_id }

end
