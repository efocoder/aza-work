class CreateV1Transactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_id, null: false, unique: true
      t.string :customer_id, null: false
      t.string :input_currency, null: false, length: { minimum: 3, maximum: 3 }
      t.decimal :input_amount, precision: 10, scale: 2, null: false
      t.string :output_currency, null: false, length: { minimum: 3, maximum: 3 }
      t.decimal :output_amount, precision: 10, scale: 2, null: false
      t.string :status, default: 'PENDING'

      t.timestamps
    end
  end
end
