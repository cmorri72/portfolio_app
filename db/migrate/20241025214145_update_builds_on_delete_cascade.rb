class UpdateBuildsOnDeleteCascade < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :builds, :customers 
    add_foreign_key :builds, :customers, on_delete: :cascade

  end
end
