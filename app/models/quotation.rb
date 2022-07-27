class Quotation < ApplicationRecord
  has_one :address
  accepts_nested_attributes_for :address
  
  has_one :transaction_info


  validates :first_name, :last_name, :email, :eval_value, :phone_number, presence: true
  validates_numericality_of :eval_value, :greater_than_or_equal_to => 0.0

end
