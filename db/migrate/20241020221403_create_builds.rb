class CreateBuilds < ActiveRecord::Migration[7.1]
  def change
    create_table :builds do |t|
      t.string :title
      t.text :notes
      t.datetime :last_modified
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
