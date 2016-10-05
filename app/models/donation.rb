class Donation < ActiveRecord::Base
  belongs_to :receiver
  belongs_to :donor

  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items

  def add_item(description, quantity, quantity_type)
    items.new(description: description, quantity: quantity, quantity_type: quantity_type)
  end
end
