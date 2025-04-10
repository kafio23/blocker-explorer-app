class CreateDataUpdate < ActiveRecord::Migration[8.0]
  def change
    create_table :data_updates do |t|
      t.integer :job_id
      t.text :logs
      t.text :errors
      t.boolean :success, default: false
      t.timestamp :started_at
      t.timestamp :finished_at, null: true

      t.timestamps
    end
  end
end
