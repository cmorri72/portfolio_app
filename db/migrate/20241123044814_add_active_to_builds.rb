class AddActiveToBuilds < ActiveRecord::Migration[7.1]
  def change
    add_column :builds, :active, :boolean
  end
end
