class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.integer :title
      t.integer :user_id
      t.integer :notification_template_id
      t.timestamps
    end
  end
end
