# frozen_string_literal: true

class User::Create < ApplicationOperation
  step Nested(User::Operation::Init)

  step Contract::Validate()
  step Contract::Persist()

  step :assign_role

  failure :log_error!
  step :notify!

  def assign_role(options, model:, params:, **)
    Role::Create.call({
                        title: options[:role]
                      },
                      user: model,
                      project: options[:project])
  end
end

# User::Create.({name: 'qqqq', email: 'qwe@qwe.qwe113'}, role: 'admin', project: Project.first)
