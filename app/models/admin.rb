class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  def donor?
   true
  end

  def receiver?
   true
  end

  def admin?
    true
  end

  def intake_survey_completed
    true
  end

  def agency_name
    false
  end

  def profile_completed?
    true
  end
end
