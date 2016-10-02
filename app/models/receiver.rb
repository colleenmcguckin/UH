class Receiver < User
  has_and_belongs_to_many :donations
end
