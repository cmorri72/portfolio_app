class RenameStudentIdToCustomerIdInBuilds < ActiveRecord::Migration[7.0]
  def change
    # Check if `student_id` exists before trying to rename it
    if column_exists?(:builds, :student_id)
      remove_column :builds, :student_id # Or handle the renaming conditionally
    end
  end
end
