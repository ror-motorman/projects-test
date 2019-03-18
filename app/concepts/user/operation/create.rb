# frozen_string_literal: true

class User::Create < ApplicationOperation
  step Nested(User::Operation::Init)
  step Contract::Validate()
  step Contract::Persist()

  step :assign_role
  failure :delete_user!

  step :notify!

  def assign_role(options, model:, params:, **)
    Role::Create.call({
                        title: options[:role]
                      },
                      user: model,
                      project: options[:project]).success?
  end

  def delete_user!(_options, model:, params:, **)
    model.destroy!
  end
end
