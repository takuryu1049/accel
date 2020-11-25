class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_num
      t.boolean :room_status
      t.integer :floor
      t.references :property
      t.timestamps
    end
  end
end
