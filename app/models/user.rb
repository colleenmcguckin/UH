class User < ActiveRecord::Base
  has_many :donations
  accepts_nested_attributes_for :donations
end
