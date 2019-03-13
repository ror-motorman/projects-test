class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable, :validatable

  has_many :roles
  has_many :notification_templates, through: :roles
  has_many :projects, through: :notification_templates

end
