class Donation < ActiveRecord::Base
  belongs_to :receiver
  belongs_to :donor

  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items
  before_save :add_tracking_code, on: [:donate]

  with_options if: :donated_at do |donation|
    donation.validates :tracking_code, uniqueness: true
  end



  def add_item(description, quantity, quantity_type)
    items.new(description: description, quantity: quantity, quantity_type: quantity_type)
  end

  def donated?
    true if donated_at
  end

  def received?
    true if received_at
  end

  def add_tracking_code
    unless tracking_code
      code = ""
      chars = %w[A B C D E F G H J K L M N P R S T X Y Z 2 3 4 5 6 7 8 9]
      5.times do
        code << chars.sample
      end

      self.tracking_code = code
    end
  end

  def donate!
    self.donated_at = Time.current
  end
end
