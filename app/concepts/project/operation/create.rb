# frozen_string_literal: true

class Project::Create < ApplicationOperation
  step Model(Project, :new)
  step Contract::Build(constant: Project::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  step :notify!
  failure :log_error!
end
