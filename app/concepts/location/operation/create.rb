# frozen_string_literal: true

class Location::Create < ApplicationOperation
  step Model(Location, :new)

  step :incoming_data
  step :assign_data

  step Contract::Build(constant: Location::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  failure :log_error!
  step :notify!

  def assign_data(options, model:, params:, **)
    model.title = params[:title]
    model.project = options[:project]
  end
end

# Location::Create.({title: 'location'}, project: Project.first)
