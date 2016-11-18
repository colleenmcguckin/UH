class Receiver < ActiveRecord::Base
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

end
