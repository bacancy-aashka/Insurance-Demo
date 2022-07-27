class CreateCardInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :card_informations do |t|
      t.string :postal_code
      t.string :email
      t.string :card_name
      t.integer :cvv
      t.integer :card_number
      t.date :expiry_date
      t.references :transaction_info, foreign_key: true

      t.timestamps
    end
  end
end
