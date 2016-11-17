class Food < ActiveRecord::Base

  belongs_to :donor
  belongs_to :category
  has_many :donation_items
end
