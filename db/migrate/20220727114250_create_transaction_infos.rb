class CreateTransactionInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_infos do |t|
      t.integer :language
      t.string :home_owner_1
      t.string :home_owner_2
      t.string :home_owner_3
      t.integer :property_type
      t.boolean :property_owner, default: false
      t.date :purchase_date
      t.text :lot_number
      t.boolean :bound_water
      t.boolean :muncipal_water
      t.boolean :insurance_issued
      t.boolean :insurance_denied
      t.text :note
      t.string :agent_name
      t.string :agent_email
      t.references :quotation, foreign_key: true
      
      

      t.timestamps
    end
  end
end
