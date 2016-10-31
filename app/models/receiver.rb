class Receiver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations
  has_many :donation_schedules

  after_create :setup_schedule

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
end
