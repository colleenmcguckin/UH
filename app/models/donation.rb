class Donation < ActiveRecord::Base
  belongs_to :receiver
  belongs_to :donor
end
