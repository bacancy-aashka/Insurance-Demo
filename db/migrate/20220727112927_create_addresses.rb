class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :postal_code
      t.string :city
      t.string :province
      t.integer :type
      t.references :quotation, foreign_key: true
      t.references :transaction_info

      t.timestamps
    end
  end
end
