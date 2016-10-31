class Receiver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations
  has_many :donation_schedules

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

  def hours_on day_of_week
    hours_of_donations.find_by(day_of_week: day_of_week)
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
