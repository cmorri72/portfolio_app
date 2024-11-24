class RemoveStudentIdFromBuilds < ActiveRecord::Migration[7.0]
  def change
    remove_column :builds, :student_id, :integer
  end
end