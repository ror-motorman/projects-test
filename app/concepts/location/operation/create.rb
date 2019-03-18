# frozen_string_literal: true

class Location::Create < ApplicationOperation
  step Model(Location, :new)

  step :assign_data

  step Contract::Build(constant: Location::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  step :notify!
  failure :log_error!

  def assign_data(options, model:, params:, **)
    model.title = params[:title]
    model.project = options[:project]
  end
end
