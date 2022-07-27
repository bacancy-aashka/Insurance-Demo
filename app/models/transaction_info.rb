class TransactionInfo < ApplicationRecord
  enum languages: [:english, :french]
  enum property_types: ['Single-family dwelling', 'Condominium', 'Undivided co-ownership', 'Duplex', 'Triplex', 'Quadruplex', '5 Units', '6 Units', 'Vacant property (no building)']

  has_one :address
  accepts_nested_attributes_for :address

  belongs_to :quotation
  validates :language, :home_owner_1, :property_type, :purchase_date, :lot_number, :bound_water, :muncipal_water, :insurance_issued, :insurance_denied, presence: true
end
