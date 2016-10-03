class User < ActiveRecord::Base

  # accepts_nested_attributes_for :donations

  scope :donor, -> { where(role: 'donor') }
  scope :receiver, -> { where(role: 'receiver') }

  def donor?
    role == 'donor'
  end

  def receiver?
    role == 'receiver'
  end
end
