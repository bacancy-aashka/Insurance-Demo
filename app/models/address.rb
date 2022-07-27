class Address < ApplicationRecord
  belongs_to :quotations, optional: true
  belongs_to :transaction_infos, optional: true

  # enum type: ["quotation_addr", "transaction_info_addr"]

  validates :address, :postal_code, :city, :province, presence: true
end
