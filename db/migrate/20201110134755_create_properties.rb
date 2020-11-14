class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :post_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :street, null: false
      t.integer :type_id, null: false
      t.integer :units, null: false
      t.integer :management_form_id, null: false
      t.integer :rank_id, null: false
      t.text :caution
      t.references :company, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: true
      t.timestamps
    end
  end
end