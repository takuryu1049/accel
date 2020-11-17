class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.boolean :swicth_owner_form, null: false, default: false
      t.string :company_name
      t.string :company_name_kana
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.boolean :gender, null: false, default: false
      t.integer :character_id
      t.text :character_about
      t.string :post_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.string :building_name
      t.string :main_communication, null: false
      t.text :communication_about, null: false
      t.string :home_phone_num
      t.string :phone_num
      t.string :other_phone_num
      t.string :fax_num
      t.string :email
      t.timestamps
    end
  end
end
