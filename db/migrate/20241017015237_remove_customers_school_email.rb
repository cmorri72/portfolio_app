class RemoveCustomersSchoolEmail < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :school_email, :string
  end
end
