class Program < ActiveRecord::Base
  belongs_to :receiver
  has_and_belongs_to_many :dietary_restrictions
  accepts_nested_attributes_for :dietary_restrictions

  validates :perishable_food_distribution, :charge_for_service, :meal_style, :staff_size, :food_type_provided, presence: true
end
