class CreateActions < ActiveRecord::Migration[8.0]
  def change
    create_table :actions do |t|
      t.string :action_type
      t.decimal :deposit, precision: 30, scale: 0
      t.jsonb :data

      t.timestamps
    end

    add_reference :actions, :txn, foreign_key: { to_table: :transactions }
    add_reference :transactions, :block, foreign_key: true
  end
end
