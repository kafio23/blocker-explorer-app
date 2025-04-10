class RenameErrorsToJobErrorsInDataUpdates < ActiveRecord::Migration[8.0]
  def change
    rename_column :data_updates, :errors, :job_errors
  end
end
