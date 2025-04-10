class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_hash, null: false, index: { unique: true }
      t.string :block_hash
      t.string :sender
      t.string :receiver
      t.boolean :success, default: false
      t.decimal :gas_burnt, precision: 30, scale: 0
      t.timestamp :time

      t.timestamps
    end
  end
end
