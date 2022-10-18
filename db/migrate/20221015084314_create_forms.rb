class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :email
      t.string :spreadsheet_id

      t.timestamps
    end
  end
end
