class CreateBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :blocks do |t|
      t.integer :height, null: false, index: { unique: true }
      t.string :block_hash, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
