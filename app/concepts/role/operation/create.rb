# frozen_string_literal: true

class Role::Create < ApplicationOperation
  step Nested(Role::Operation::Init)

  step Contract::Validate()
  step Contract::Persist()

  failure :log_error!
  step :notify!
end

# Role::Create.({title: 'user'}, user: User.first, project: Project.first)
