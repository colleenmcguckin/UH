class Donor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations
  has_many :foods

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def donor?
    true
  end

  def admin?
    false
  end

  def receiver?
    false
  end

  def profile_completed?
    if contact_phone && contact_email && contact_name
      return true
    else
      false
    end
  end

end
