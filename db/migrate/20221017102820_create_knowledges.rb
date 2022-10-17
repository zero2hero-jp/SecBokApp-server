class CreateKnowledges < ActiveRecord::Migration[7.0]
  def change
    create_table :knowledges do |t|
      t.integer :sheet_id
      t.string :role
      t.decimal :score, precision: 7, scale: 4

      t.timestamps
    end
  end
end
