class CreateUtilities < ActiveRecord::Migration[6.0]
  def change
    create_table :utilities do |t|
      t.integer :water_supply, null: false
      t.integer :sewer, null: false
      t.integer :electrical, null: false
      t.integer :gas, null: false
      t.references :property, null: false, foreign_key: true
      t.timestamps
    end
  end
end
