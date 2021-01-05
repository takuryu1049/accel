class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_num
      t.string :management_form, null: false, default: "O"
      t.integer :floor, null: false
      t.string :room_status, null: false, default: "V"
      t.string :key_place
      t.string :mail_num
      t.references :property
      t.timestamps
    end
  end
end
