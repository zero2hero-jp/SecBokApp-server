class ChangeFormsToSheets < ActiveRecord::Migration[7.0]
  def change
    rename_table :forms, :sheets
  end
end
