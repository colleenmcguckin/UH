class Food < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :donor
  belongs_to :category
  has_many :donation_items

  def remove_from_pending_donations
    DonationItem.where(food_id: self.id).each do |item|
      unless item.donation.donated?
        item.destroy!
      end
    end
  end
end
