# frozen_string_literal: true

class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable

  has_many :roles
  has_many :notification_templates, -> { distinct }, through: :roles
  has_many :projects, -> { distinct }, through: :notification_templates
  has_many :locations, -> { distinct }, through: :projects
end
