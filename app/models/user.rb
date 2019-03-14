# frozen_string_literal: true

class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable

  has_many :roles
  has_many :notification_templates, through: :roles
  has_many :projects, through: :notification_templates
end
