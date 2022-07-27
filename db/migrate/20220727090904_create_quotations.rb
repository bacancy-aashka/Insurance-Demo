class CreateQuotations < ActiveRecord::Migration[6.0]
  def change
    create_table :quotations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.float :eval_value
      t.float :insurance_value

      t.timestamps
    end
  end
end
