# frozen_string_literal: true

class CreateNotificationTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_templates do |t|
      t.integer :project_id
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
