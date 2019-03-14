# frozen_string_literal: true

class Role < ApplicationRecord
  POSSIBLE_TITLES = %w[admin user guest].freeze

  belongs_to :user
  belongs_to :notification_template
end
