class Food < ActiveRecord::Base
  belongs_to :donor
  belongs_to :category
end
