# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :notification_templates
  has_many :roles, -> { distinct }, through: :notification_templates
  has_many :users, -> { distinct }, through: :roles
  has_many :locations
end
