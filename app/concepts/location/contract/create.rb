# frozen_string_literal: true

class Location::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :project_id
  property :title

  validation do
    required(:project_id) { int? & gt?(0) }
    required(:title).filled
  end
end
