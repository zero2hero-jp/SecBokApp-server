class CreateYears < ActiveRecord::Migration[7.0]
  def change
    create_table :years do |t|
      t.integer :sheet_id
      t.string :title
      t.integer :l
      t.integer :m
      t.integer :h

      t.timestamps
    end
  end
end
