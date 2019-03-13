class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :project_id
      t.string :title
      t.timestamps
    end
  end
end
