class FixAdminsTableForDevise < ActiveRecord::Migration[7.1]
  def change
    # Remove the incompatible password_digest column
    remove_column :admins, :password_digest, :string

    # Add the encrypted_password column required by Devise
    add_column :admins, :encrypted_password, :string, null: false, default: ""

    # Add Devise-required columns for password resets and remembering sessions
    add_column :admins, :reset_password_token, :string
    add_column :admins, :reset_password_sent_at, :datetime
    add_column :admins, :remember_created_at, :datetime

    # Add indexes for Devise
    add_index :admins, :email, unique: true
    add_index :admins, :reset_password_token, unique: true
  end
end

