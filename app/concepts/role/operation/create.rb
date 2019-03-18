# frozen_string_literal: true

class Role::Create < ApplicationOperation
  step Nested(Role::Operation::Init)

  step Contract::Validate()
  step Contract::Persist()

  step :notify!
  failure :log_error!
end
