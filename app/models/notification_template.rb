class NotificationTemplate < ApplicationRecord
  belongs_to :project
  has_many :roles
end
