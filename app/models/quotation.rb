class Quotation < ApplicationRecord
  has_one :address
  accepts_nested_attributes_for :address
  
  has_one :transaction_info


  validates :first_name, :last_name, :email, :eval_value, :phone_number, presence: true
  validates_numericality_of :eval_value, :greater_than_or_equal_to => 0.0
  
  def calculate_insurance_premium(eval)
    prime_tx = ((((eval-500000)/1000)*1.17)+320)
    ((prime_tx.round(2) + 20 + (prime_tx*0.09).round(2)).abs).round(2)
  end
  

end
