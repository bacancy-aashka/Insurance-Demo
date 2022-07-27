class ChangeColumnPhone < ActiveRecord::Migration[6.0]
  def change
    change_column :callback_informations, :phone_number, :string
  end
end
