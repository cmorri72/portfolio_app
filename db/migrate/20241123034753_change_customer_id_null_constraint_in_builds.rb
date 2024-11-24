class ChangeCustomerIdNullConstraintInBuilds < ActiveRecord::Migration[7.0]
  def change
    change_column_null :builds, :customer_id, true
  end
end