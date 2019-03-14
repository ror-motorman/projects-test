# frozen_string_literal: true

class Project::Create < ApplicationOperation
  step Model(Project, :new)
  step Contract::Build(constant: Project::Contract::Create)
  step Contract::Validate()
  step Contract::Persist()

  failure :log_error!
  step :notify!
end

# Project::Create.({title: 'project'})
