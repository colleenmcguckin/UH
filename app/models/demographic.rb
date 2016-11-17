class Demographic < ActiveRecord::Base
  PERCENTAGE_RANGES = ['0-15', '16-30', '31-45', '46-60', '61-75', '76-90', '91-100', 'N/A'].freeze
  belongs_to :receiver

  validates :percent_male, presence: true
  validates :percent_female, presence: true
  validates :percent_other_gender, presence: true
  validates :percent_youth, presence: true
  validates :percent_adult, presence: true
  validates :percent_senior, presence: true
  validates :percent_american_native, presence: true
  validates :percent_african_american, presence: true
  validates :percent_asian, presence: true
  validates :percent_hispanic, presence: true
  validates :percent_pacific_islander, presence: true
  validates :percent_white, presence: true
  validates :percent_portuguese, presence: true
  validates :percent_single_no_kids, presence: true
  validates :percent_single_with_kids, presence: true
  validates :percentage_married_no_kids, presence: true
  validates :percentage_married_with_kids, presence: true
  validates :precent_employed, presence: true
  validates :percent_unemployed, presence: true
  validates :percent_veteran_military, presence: true
  validates :percent_active_military, presence: true
  validates :percentage_with_dietary_restrictions, presence: true
  validates :total_guests_served_per_week, presence: true
  validates :meals_served_per_breakfast, presence: true
  validates :meals_served_per_lunch, presence: true
  validates :meals_served_per_dinner, presence: true
  validates :total_receiving_groceries, presence: true
  validates :mode_of_transportation, presence: true
  validates :distance_traveled, presence: true
  validates :receiver_id, presence: true
end
