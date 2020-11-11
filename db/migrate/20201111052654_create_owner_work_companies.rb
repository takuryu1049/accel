class CreateOwnerWorkCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :owner_work_companies do |t|
      t.string :company_name
      t.string :company_name_kana
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :street
      t.string :building_name
      t.string :company_phone_num
      t.string :job_description
      t.references :owner, null: false, foreign_key: true
      t.timestamps
    end
  end
end
