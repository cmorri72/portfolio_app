class RemoveMajorAndExpectedGraduationDateFromCustomers < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :major, :string
    remove_column :customers, :expected_graduation_date, :date
  end
end
