class Donation < ActiveRecord::Base
  has_and_belongs_to_many :donors
  has_and_belongs_to_many :receivers
  #
  # belongs_to :donor, class_name: 'User', foreign_key: :donor_id
  # belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items

  # before_validation :generate_tracking_code
  #
  # with_options if: :has_receiver? do |donation|
  #   donation.validates :tracking_code, uniqueness: true
  # end

  def add_item(description, quantity, quantity_type)
    items.new(description: description, quantity: quantity, quantity_type: quantity_type)
  end

  def generate_tracking_code
    self.tracking_code = SecureRandom.hex(4)
  end

end
