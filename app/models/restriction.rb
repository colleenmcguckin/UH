class Restriction < ActiveRecord::Base
  belongs_to :receiver
  has_and_belongs_to_many :storage_temps
  has_and_belongs_to_many :categories
end
