class Receiver < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations

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
end
