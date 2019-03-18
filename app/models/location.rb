# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :project
  has_many :users, -> { distinct }, through: :project
end
