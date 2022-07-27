class CreateCallbackInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :callback_informations do |t|
      t.integer :phone_number
      t.integer :call_availability
      t.references :transaction_info, foreign_key: true


      t.timestamps
    end
  end
end
