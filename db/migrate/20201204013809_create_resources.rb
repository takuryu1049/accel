class CreateResources < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.integer :brokerage_fee, null: false
      t.integer :add_fee, null: false
      t.timestamps
    end
  end
end
