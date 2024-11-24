class AddDeviseToCustomers < ActiveRecord::Migration[7.0]
  def up
    # Add Devise fields if they don't already exist
    unless column_exists?(:customers, :email)
      add_column :customers, :email, :string, null: false, default: ""
    end

    unless column_exists?(:customers, :encrypted_password)
      add_column :customers, :encrypted_password, :string, null: false, default: ""
    end

    add_column :customers, :reset_password_token, :string unless column_exists?(:customers, :reset_password_token)
    add_column :customers, :reset_password_sent_at, :datetime unless column_exists?(:customers, :reset_password_sent_at)
    add_column :customers, :remember_created_at, :datetime unless column_exists?(:customers, :remember_created_at)

    # Add indexes for Devise fields if they don't already exist
    add_index :customers, :email, unique: true unless index_exists?(:customers, :email)
    add_index :customers, :reset_password_token, unique: true unless index_exists?(:customers, :reset_password_token)
  end

  def down
    # Remove Devise fields
    remove_index :customers, :reset_password_token if index_exists?(:customers, :reset_password_token)
    remove_column :customers, :reset_password_token if column_exists?(:customers, :reset_password_token)
    remove_column :customers, :reset_password_sent_at if column_exists?(:customers, :reset_password_sent_at)
    remove_column :customers, :remember_created_at if column_exists?(:customers, :remember_created_at)
    remove_column :customers, :encrypted_password if column_exists?(:customers, :encrypted_password)

    # Remove email column and its index
    remove_index :customers, :email if index_exists?(:customers, :email)
    remove_column :customers, :email if column_exists?(:customers, :email)
  end
end
