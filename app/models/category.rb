class Category < ActiveRecord::Base
  has_many :foods
  has_and_belongs_to_many :storage_temps
  has_and_belongs_to_many :restrictions
end
