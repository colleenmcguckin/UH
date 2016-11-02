class DonationSchedule < ActiveRecord::Base
  belongs_to :receiver

  DAYS_IN_WORDS = %w[sunday monday tuesday wednesday thursday friday saturday]
  HOURS_OF_THE_DAY = ['12 am'] + (1..11).map {|h| "#{h} am"} + ['12 pm'] + (1..11).map {|h| "#{h} pm"}

  validates :day_of_week, uniqueness: { scope: :receiver_id }

  def closed?
    open_at_hour.blank? || close_at_hour.blank?
  end

  def day_of_week_in_words
    DAYS_IN_WORDS[day_of_week]
  end
end
