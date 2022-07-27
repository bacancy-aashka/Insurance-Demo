class TransactionInfo < ApplicationRecord
  enum languages: [:english, :french]
  enum property_types: ['Single-family dwelling', 'Condominium', 'Undivided co-ownership', 'Duplex', 'Triplex', 'Quadruplex', '5 Units', '6 Units', 'Vacant property (no building)']

  has_one :address
  accepts_nested_attributes_for :address
  
  belongs_to :quotation, optional: true
end
