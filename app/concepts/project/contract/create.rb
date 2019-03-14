# frozen_string_literal: true

class Project::Contract::Create < Reform::Form
  feature Reform::Form::Dry

  property :title

  validation do
    required(:title).filled
  end
end
