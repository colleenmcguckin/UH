class Food < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :donor
  belongs_to :category
  has_many :donation_items

  validates :name, presence: true
  validates :storage_temp, presence: true
  validates :donor_id, presence: true
  validates :category_id, presence: true

  def remove_from_pending_donations
    DonationItem.where(food_id: self.id).each do |item|
      unless item.donation.donated?
        item.destroy!
      end
    end
  end

  def donation_count
    DonationItem.where(food_id: self.id).to_a.count{ |item| item.donation.donated? }
  end
end
