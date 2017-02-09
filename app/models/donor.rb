class Donor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations
  has_many :foods

  def donor?
    true
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
