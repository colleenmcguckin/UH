class Donation < ActiveRecord::Base
  include AASM

  belongs_to :receiver
  belongs_to :donor

  has_many :items, class_name: 'DonationItem'
  accepts_nested_attributes_for :items
  before_save :add_tracking_code, on: [:donate]

  with_options if: :donated_at do |donation|
    donation.validates :tracking_code, uniqueness: true
  end

  def add_item description, quantity, quantity_type
    items.new description: description, quantity: quantity, quantity_type: quantity_type
  end

  def donated?
    donated_at?
  end

  def received?
    received_at?
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

  aasm do
    state :started, initial: true
    state :confirmed_donated, :confirmed_received

    event :confirm_donation do
      transitions from: :started, to: :confirmed_donated, guard: [:items_added?, :receiver_added?]
    end

    event :confirm_receipt do
      transitions from: [:started, :receiver_added], to: :confirmed_received
    end

    def items_added?
      items.any?
    end

    def receiver_added?
      receiver.present?
    end
  end
end
