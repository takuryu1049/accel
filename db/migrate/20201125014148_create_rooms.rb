class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_num
      t.string :room_status, null: false, default: "V"
      t.integer :floor
      t.references :property
      t.timestamps
    end
  end
end
