class DonationItem < ActiveRecord::Base
  belongs_to :donation
  belongs_to :food

  QUANTITY_TYPES = %w[pound(s) tray(s) unit(s)].freeze
end
