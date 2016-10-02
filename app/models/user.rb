class User < ActiveRecord::Base

  has_and_belongs_to_many :donations

  accepts_nested_attributes_for :donations

  scope :donor, -> { where(role: 'donor') }
  scope :receiver, -> { where(role: 'receiver') }

  def donor?
    role == 'donor'
  end

  def receiver?
    role == 'receiver'
  end
end
