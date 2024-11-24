class RemoveSchoolEmailFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :school_email, :string, if_exists: true
  end
end