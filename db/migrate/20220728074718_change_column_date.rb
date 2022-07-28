class ChangeColumnDate < ActiveRecord::Migration[6.0]
  def change
    change_column :card_informations, :expiry_date, :string
  end
end
