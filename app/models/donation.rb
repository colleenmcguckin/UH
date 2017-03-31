class Donation < ActiveRecord::Base

  belongs_to :receiver
  belongs_to :donor

  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items, allow_destroy: true
  before_save :add_tracking_code, on: [:donate]

  with_options if: :donated_at do |donation|
    donation.validates :tracking_code, uniqueness: true
  end

  scope :donated, ->{ where.not(donated_at: nil) }
  scope :received, -> { donated.where.not(received_at: nil) }

  def add_item food, quantity, quantity_type
    items.new food_id: food.id, quantity: quantity, quantity_type: quantity_type
  end

  def donated?
    donated_at?
  end

  def received?
    received_at?
  end

  def confirmed_by_donor?
    confirmed_by_donor_at?
  end

  def add_tracking_code
    unless tracking_code
      chars = %w[A B C D E F G H J K L M N P R S T X Y Z 2 3 4 5 6 7 8 9]

      tracking_codes = Donation.pluck :tracking_code
      code = ''
      loop { break if !tracking_codes.include? code = chars.sample(5).join }

      self.tracking_code = code
    end
  end

  def donate!
    self.donated_at = Time.current
    self.save
  end

  def receive!
    self.received_at = Time.current
    self.save
  end

  def summary_completed?
    true if !total_weight.empty? && total_meals && total_value_dollars
  end

end
