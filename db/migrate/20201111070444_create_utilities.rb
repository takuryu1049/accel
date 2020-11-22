class CreateUtilities < ActiveRecord::Migration[6.0]
  def change
    create_table :utilities do |t|
      t.integer :water_supply_id, null: false
      t.integer :sewer_id, null: false
      t.integer :electrical_id, null: false
      t.integer :ga_id, null: false
      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
