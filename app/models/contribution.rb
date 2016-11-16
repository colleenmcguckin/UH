class Contribution < ActiveRecord::Base
  belongs_to :receiver
  has_and_belongs_to_many :logistics
end
