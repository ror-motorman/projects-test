# frozen_string_literal: true

class NotificationTemplate < ApplicationRecord
  belongs_to :project
  has_many :roles

  scope :for_role, ->(role) { where(':role = ANY(suitable_roles)', role: role) }
end
