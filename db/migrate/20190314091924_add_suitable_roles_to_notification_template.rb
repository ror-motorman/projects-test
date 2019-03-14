# frozen_string_literal: true

class AddSuitableRolesToNotificationTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_templates, :suitable_roles, :text, array: true, default: []
  end
end
