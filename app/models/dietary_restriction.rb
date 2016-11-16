class DietaryRestriction < ActiveRecord::Base
  belongs_to :receiver
  has_and_belongs_to_many :programs
end
