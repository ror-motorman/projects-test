# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :notification_templates
  has_many :locations
end
