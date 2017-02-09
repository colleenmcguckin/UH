class Logistic < ActiveRecord::Base
  belongs_to :receiver
  has_and_belongs_to_many :contributions

  validates :transportation_available, :driver_status, :insurance_status, :vehicle_style, :freezer_type,
            :refrigerator_type, :indoor_dry_storage, :safe_handling_program, :meal_usage, :meal_distribution_frequency, presence: true
end
