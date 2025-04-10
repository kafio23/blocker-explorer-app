class ChangeJobIdToBeStringInDataUpdates < ActiveRecord::Migration[8.0]
  def change
    change_column :data_updates, :job_id, :string
  end
end
