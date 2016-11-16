class Logistic < ActiveRecord::Base
  belongs_to :receiver
  # has_and_belongs_to_many :dietary_restrictions
  # accepts_nested_attributes_for :dietary_restrictions
end
