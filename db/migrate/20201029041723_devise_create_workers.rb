# frozen_string_literal: true

class DeviseCreateWorkers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      ## Database authenticatable
      t.string :worker_login_id, null: false, uniqueness: true
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.boolean :gender, null: false, default: false
      t.date :born, null: false
      t.integer :character_id, null: false
      t.integer :position_id, null: false
      t.integer :qualification_id
      t.references :company, null: false, foreign_key: true
      t.string :email,              null: false, default: "", uniqueness: true
      t.string :encrypted_password, null: false, default: ""
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :workers, :email,                unique: true
    add_index :workers, :reset_password_token, unique: true
    add_index :workers, :worker_login_id, unique: true
    # add_index :workers, :confirmation_token,   unique: true
    # add_index :workers, :unlock_token,         unique: true
  end
end
