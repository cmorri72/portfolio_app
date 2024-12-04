class FixAdminsPasswordColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :admins, :password_digest, :string
    add_column :admins, :encrypted_password, :string, null: false, default: ""
  end
end

