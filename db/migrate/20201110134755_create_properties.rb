class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|

      t.timestamps
    end
  end
end
