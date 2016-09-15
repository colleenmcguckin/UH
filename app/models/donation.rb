class Donation < ActiveRecord::Base
  belongs_to :donor, class_name: 'User', foreign_key: :donor_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items

  def add_item(description, quantity, quantity_type)
    items.new(description: description, quantity: quantity, quantity_type: quantity_type)
  end

end
