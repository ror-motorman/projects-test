# frozen_string_literal: true

class Role::Operation::Init < ApplicationOperation
  step Model(Role, :new)
  step :assign_data
  step Contract::Build(constant: Role::Contract::Create)

  step :notify!

  def assign_data(options, model:, params:, **)
    model.title = params[:title]
    model.user = options[:user]
    model.notification_template = options[:project].notification_templates.for_role(params[:title]).first
  end
end
