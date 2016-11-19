class Receiver < ActiveRecord::Base
  paginates_per 5
  geocoded_by :zip

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations
  has_many :donation_schedules
  has_many :contact_details
  has_many :demographics
  accepts_nested_attributes_for :demographics
  has_many :programs
  has_many :dietary_restrictions, through: :programs
  has_many :logistics
  has_many :contributions, through: :logistics
  has_many :restrictions

  after_create :setup_schedule
  after_validation :geocode, if: ->(obj){ obj.street_address.present? and obj.street_address_changed? }


  # validates_format_of :tax_id, with: /^[1-9]\d?-\d{7}$/, :on => :create

  def donor?
    false
  end

  def receiver?
    true
  end

  def verify!
    #hit the api
    #if verified update verified_at field
    #if rejected give notice
  end

  def transportation_available?
    logistics.first.transportation_available == 'Yes'
  end

  def setup_schedule
    0.upto(6) do |i|
      self.donation_schedules.create(
        day_of_week: i
      )
    end
  end

  def hours_on day_of_week
    self.donation_schedules.find_by(day_of_week: day_of_week)
  end

  def paused?
    true if paused
  end

  def pause!
    self.paused = true
    self.save
  end

  def unpause!
    self.paused = false
    self.save
  end

  def pending_donation_count
    Donation.where(receiver_id: self.id).to_a.count{ |donation| donation.donated? && !donation.received? }
  end

  def pending_donation_items
    items = []
    Donation.where(receiver_id: self.id).where("donated_at IS NOT NULL").where(received_at: nil).each do |d|
      d.items.each do |i|
        items << i
      end
    end
    return items
  end

  def address
    [street_address, city, state, 'USA'].compact.join(', ')
  end

  def self.filter donation
    # get rid of receivers who have restrictions that are included in the donation
    # this will be either a category through the food, or a storage_temp on the food, which is one of many items on the donation
    # Receiver where each receiver.restrictions.first.categories != each donation.items.(first/2nd/etc).food.category
    # && each restricions.first.storage_temps != each donation.items.(first/2nd/etc).food.storage_temp
    categories_to_exclude = donation.items.map(&:food).map(&:category)
    storage_temps_to_exclude = donation.items.map(&:food).map(&:storage_temp)

    # Receiver.includes(restrictions: [:categories, :storage_temps]).map(&:category)
  end

end
