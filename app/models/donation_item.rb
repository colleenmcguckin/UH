class DonationItem < ActiveRecord::Base
  belongs_to :donation
  belongs_to :food

  validates :food_id,
            :quantity,
            :quantity_type,
            :donation_id, presence: true, on: :create

  QUANTITY_TYPES = %w[pound(s) tray(s) unit(s)].freeze
end
