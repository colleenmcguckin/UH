class ContactDetail < ActiveRecord::Base
  belongs_to :receiver

  validates :contact_name, presence: true
  validates :contact_email, presence: true
  validates :contact_phone, presence: true
  validates :dfr_contact_name, presence: true
  validates :dfr_contact_email, presence: true
  validates :dfr_contact_office_phone, presence: true
  validates :dfr_contact_cell_phone, presence: true
  validates :dfr_preferred_contact_method, presence: true
  validates :receiver_id, presence: true
end
