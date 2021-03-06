require "http"

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
  accepts_nested_attributes_for :contact_details
  has_many :demographics
  accepts_nested_attributes_for :demographics
  has_many :programs
  accepts_nested_attributes_for :programs
  has_many :dietary_restrictions, through: :programs
  has_many :logistics
  accepts_nested_attributes_for :logistics
  has_many :contributions, through: :logistics
  has_many :restrictions
  accepts_nested_attributes_for :restrictions

  after_create :setup_schedule
  after_validation :geocode, if: ->(obj){ obj.street_address.present? and obj.street_address_changed? }

  scope :paused, ->{ where(paused: true) }
  scope :unpaused, ->{ where(paused: false) }

  # validates_format_of :tax_id, with: /^[1-9]\d?-\d{7}$/, :on => :create
  validates_numericality_of :tax_id, on: :update, message: 'Omit special characters and only use numbers in this box.'
  validates_length_of :tax_id, is: 9, on: :update
  validates :agency_name, :street_address, :city, :state, :zip, presence: true, on: :update
  validates_numericality_of :zip, on: :update
  validates_length_of :zip, is: 5, on: :update, message: 'must be 5 Digits.'

  def donor?
    false
  end

  def receiver?
    true
  end

  def admin?
    false
  end

  def verify!
    response = Http.head "http://138.197.214.141/#{tax_id}"
    if response.status == 200
      true
    else
      false
    end
  end

  def transportation_available?
    logistics.first&.transportation_available == 'Yes'
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

    receivers_to_keep = Receiver.select do |receiver|
      receiver.restrictions.none? do |restriction|
        restriction.categories.any? do |category|
          categories_to_exclude.include?(category) || restriction.storage_temps.any? do |temp|
            storage_temps_to_exclude.include? temp
          end
        end
      end
    end

    Receiver.where id: receivers_to_keep.map(&:id)
  end

  def website
    return unless web_url
    unless web_url.include? "http://"
      "http://#{web_url}"
    end
  end

end
